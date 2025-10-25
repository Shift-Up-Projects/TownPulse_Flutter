part of 'user_register_cubit.dart';

@immutable
sealed class UserRegisterState {}

final class UserRegisterInitial extends UserRegisterState {}

final class UserRegisterSuccessfullyState extends UserRegisterState {
  final String message;
  UserRegisterSuccessfullyState({required this.message});
}
final class UserRegisterFailureState extends UserRegisterState {
  final String errorMessage;
  UserRegisterFailureState({required this.errorMessage});
}
final class UserRegisterLoadingState extends UserRegisterState {}
