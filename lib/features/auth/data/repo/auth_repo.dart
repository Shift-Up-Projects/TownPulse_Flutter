import 'package:dart_either/dart_either.dart';
import 'package:town_pulse2/core/errors/failure.dart';
import 'package:town_pulse2/features/auth/data/model/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, String>> userSignIn({
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> userSignUp({
    required String userName,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> fetchCurrentUser(String token);
  Future<Either<Failure, User>> updateProfile({
    required String token,
    required String name,
    required String email,
  });
  Future<Either<Failure, String>> updatePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  });
  Future<Either<Failure, String>> userLogout(String token);
  Future<Either<Failure, String>> forgotPassword({required String email});
}
