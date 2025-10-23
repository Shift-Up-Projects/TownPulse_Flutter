import 'dart:developer';
import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:town_pulse2/core/errors/failure.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/core/utils/api_services.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  Future<Either<Failure, String>> userSignIn({
    required String email,
    required String password,
  }) async {
    try {
      final body = {'email': email.trim(), 'password': password.trim()};

      final response = await Api.instance.post(url: 'users/login', body: body);

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final token = response.data['data']['token'] as String;

        Api.instance.setToken(token);
        await CacheHelper.saveData(key: 'token', value: token);
        await CacheHelper.saveData(
          key: 'user_id',
          value: response.data['data']['user']['_id'],
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
Future<Either<Failure, String>> userSignUp({required String email, required String password,required String userName}
    ) async {
  try {
    final cleanedEmail = email.trim();
    final cleanName = userName.trim();
    final cleanedPassword = password.trim();
    final body = {
      'name': cleanName,
      'email': cleanedEmail,
      'password': cleanedPassword
    };
    log('Sending Register request with: $body');
    final response = await Api.instance.post(
      url: 'users/signup',
      body: body,
    );
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      String token = response.data['data']['token'];
      log('Login response: ${response.data}');
      log(token);
      CacheHelper.saveData(key: 'isLogin', value: token);
      return Right('user Register Successfully');
    } else {
      return Left(ServerFailure.fromResponse(
          response.statusCode ?? 500,
          response.data
      ));
    }
  } on DioException catch (e) {
    return Left(ServerFailure.fromDioException(e));
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}
}
  @override
  Future<Either<Failure, String>> userSignUp() {
    // TODO: implement userSignUp
    throw UnimplementedError();
  }
}
