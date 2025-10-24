import 'dart:developer';
import 'dart:convert';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:town_pulse2/core/errors/failure.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/core/utils/api_services.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo.dart';
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
        final userData = responseData['user'] as Map<String, dynamic>;
        final userId = userData['_id'];

        Api.instance.setToken(token);
        await CacheHelper.saveData(key: 'token', value: token);
        await CacheHelper.saveData(key: 'user_id', value: userId);
        await CacheHelper.saveData(
          key: 'user_data_json',
          value: json.encode(userData),
        );

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
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> fetchCurrentUser(String token) async {
    try {
      final userDataJson =
          CacheHelper.getData(key: 'user_data_json') as String?;

      if (userDataJson == null || userDataJson.isEmpty) {
        return Left(
          ServerFailure(
            'لا تتوفر بيانات الملف الشخصي محلياً. يرجى إعادة تسجيل الدخول.',
          ),
        );
      }

      final userData = json.decode(userDataJson) as Map<String, dynamic>;
      final user = User.fromJson(userData);

      return Right(user);
    } catch (e) {
      return Left(
        ServerFailure('فشل في تحليل بيانات المستخدم المحلية: ${e.toString()}'),
      );
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

        await CacheHelper.saveData(
          key: 'user_data_json',
          value: json.encode(userData),
        );

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
      await CacheHelper.removeData(key: 'user_data_json');
      await CacheHelper.removeData(key: 'token');
      await CacheHelper.removeData(key: 'user_id');
      Api.instance.setToken('');

      return const Right('تم تسجيل الخروج بنجاح');
    } on DioException {
      await CacheHelper.removeData(key: 'user_data_json');
      await CacheHelper.removeData(key: 'token');
      await CacheHelper.removeData(key: 'user_id');
      Api.instance.setToken('');
      return const Right('تم تسجيل الخروج');
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
