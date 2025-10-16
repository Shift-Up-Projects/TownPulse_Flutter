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

        // 🟢 حفظ التوكن في Api Singleton
        Api.instance.setToken(token);
        await CacheHelper.saveData(key: 'token', value: token);

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
}
