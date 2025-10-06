part of 'user_login_cubit.dart';

@immutable
sealed class UserLoginState {}

final class UserLoginInitial extends UserLoginState {}
final class UserLoginSuccessfullyState extends UserLoginState {
  final String message;

  UserLoginSuccessfullyState({required this.message});
}
final class UserLoginFailureState extends UserLoginState {
  final String errorMessage;

  UserLoginFailureState({required this.errorMessage});

}
final class UserLoginLoadingState extends UserLoginState {


}
