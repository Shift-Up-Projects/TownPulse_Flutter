import 'package:town_pulse2/features/auth/data/model/user_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  final User user;
  ProfileUpdateSuccess(this.user);
}

class ProfileUpdateError extends ProfileState {
  final String message;
  ProfileUpdateError(this.message);
}

class PasswordUpdating extends ProfileState {}

class PasswordUpdateSuccess extends ProfileState {
  final String message;
  PasswordUpdateSuccess(this.message);
}

class PasswordUpdateError extends ProfileState {
  final String message;
  PasswordUpdateError(this.message);
}

class ProfileLogoutSuccess extends ProfileState {}
