import 'package:dart_either/dart_either.dart';
import 'package:town_pulse2/core/errors/failure.dart';

abstract class AuthRepo{
  Future<Either<Failure,String>> userSignIn({required String email,required String password});
  Future<Either<Failure,String>> userSignUp({required String userName,required String email,required String password});
}

abstract class AuthRepo {
  Future<Either<Failure, String>> userSignIn({
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> userSignUp();
}
