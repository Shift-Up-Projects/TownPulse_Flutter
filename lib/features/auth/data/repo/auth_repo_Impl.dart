// lib/features/auth/data/repo/auth_repo_Impl.dart
import 'dart:developer';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:town_pulse2/core/errors/failure.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/core/utils/api_services.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo.dart';
// ✅ استيراد موديل المستخدم
import 'package:town_pulse2/features/auth/data/model/user_model.dart';

class AuthRepoImpl implements AuthRepo {
  Future<Either<Failure, String>> userSignIn({
    required String email,
    required String password,
  }) async {
    try {
      final body = {'email': email.trim(), 'password': password.trim()};

      final response = await Api.instance.post(url: 'users/login', body: body);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final responseData = response.data['data'] as Map<String, dynamic>?;

        if (responseData == null) {
          return Left(
            ServerFailure('فشل استخراج بيانات تسجيل الدخول من الرد.'),
          );
        }

        final token = responseData['token'] as String;
        final userId = responseData['user']['_id'];

        Api.instance.setToken(token);
        await CacheHelper.saveData(key: 'token', value: token);
        await CacheHelper.saveData(key: 'user_id', value: userId);

        log('Login Success. Token: $token');

        return Right('User logged in successfully');
      } else {
        return Left(
          ServerFailure.fromResponse(response.statusCode ?? 500, response.data),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> userSignUp() {
    // TODO: implement userSignUp
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> fetchCurrentUser(String token) async {
    try {
      final userId = CacheHelper.getData(key: 'user_id') as String?;

      if (userId == null) {
        return Left(
          ServerFailure(
            'معرف المستخدم غير موجود محلياً. الرجاء تسجيل الدخول مرة أخرى.',
          ),
        );
      }

      final response = await Api.instance.get(
        url: 'users/$userId',
        token: token,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        // ✅ FIX: الوصول مباشرة إلى 'data' وهو كائن المستخدم
        final userData = response.data?['data'];

        if (userData == null || userData is! Map<String, dynamic>) {
          return Left(
            ServerFailure(
              'لم يتم العثور على بيانات المستخدم أو هيكلها غير صحيح.',
            ),
          );
        }

        final user = User.fromJson(userData as Map<String, dynamic>);
        return Right(user);
      } else {
        return Left(
          ServerFailure.fromResponse(response.statusCode ?? 500, response.data),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    required String token,
    required String name,
    required String email,
  }) async {
    try {
      final body = {'name': name, 'email': email};
      final response = await Api.instance.put(
        url: 'users/updateMe',
        body: body,
        token: token,
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final userData = response.data?['data'];

        if (userData == null || userData is! Map<String, dynamic>) {
          return Left(ServerFailure('فشل استخراج بيانات المستخدم المحدثة.'));
        }

        final user = User.fromJson(userData);
        await fetchCurrentUser(token);
        return Right(user);
      } else {
        return Left(
          ServerFailure.fromResponse(response.statusCode ?? 500, response.data),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updatePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final body = {
        'passwordCurrent': currentPassword,
        'password': newPassword,
      };
      final response = await Api.instance.put(
        url: 'users/updateMyPassword',
        body: body,
        token: token,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return Right('تم تحديث كلمة المرور بنجاح');
      } else {
        return Left(
          ServerFailure.fromResponse(response.statusCode ?? 500, response.data),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> userLogout(String token) async {
    try {
      await Api.instance.get(url: 'users/logout', token: token);
      await CacheHelper.removeData(key: 'token');
      await CacheHelper.removeData(key: 'user_id');
      Api.instance.setToken('');

      return const Right('تم تسجيل الخروج بنجاح');
    } on DioException catch (e) {
      await CacheHelper.removeData(key: 'token');
      await CacheHelper.removeData(key: 'user_id');
      Api.instance.setToken('');
      return const Right('تم تسجيل الخروج');
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
