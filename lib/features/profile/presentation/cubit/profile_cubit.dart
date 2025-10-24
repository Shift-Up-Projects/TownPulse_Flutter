// lib/features/profile/presentation/cubit/profile_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo.dart';
import 'package:town_pulse2/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepo authRepo;

  ProfileCubit(this.authRepo) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);
  String? get token => CacheHelper.getData(key: 'token') as String?;

  Future<void> fetchCurrentUser() async {
    if (token == null) {
      emit(ProfileError('الرجاء تسجيل الدخول أولاً'));
      return;
    }

    emit(ProfileLoading());
    final result = await authRepo.fetchCurrentUser(token!);
    result.fold(
      ifLeft: (failure) => emit(ProfileError(failure.errorMessage)),
      ifRight: (user) => emit(ProfileLoaded(user)),
    );
  }

  Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    if (token == null) {
      emit(ProfileUpdateError('الرجاء تسجيل الدخول أولاً'));
      return;
    }

    emit(ProfileUpdating());
    final result = await authRepo.updateProfile(
      token: token!,
      name: name,
      email: email,
    );
    result.fold(
      ifLeft: (failure) => emit(ProfileUpdateError(failure.errorMessage)),
      ifRight: (user) => emit(ProfileUpdateSuccess(user)),
    );
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (token == null) {
      emit(PasswordUpdateError('الرجاء تسجيل الدخول أولاً'));
      return;
    }

    emit(PasswordUpdating());
    final result = await authRepo.updatePassword(
      token: token!,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    result.fold(
      ifLeft: (failure) => emit(PasswordUpdateError(failure.errorMessage)),
      ifRight: (message) => emit(PasswordUpdateSuccess(message)),
    );
  }

  Future<void> userLogout() async {
    if (token == null) {
      if (!isClosed) {
        emit(ProfileLogoutSuccess());
      }
      return;
    }

    final result = await authRepo.userLogout(token!);

    result.fold(
      ifLeft: (failure) {
        if (!isClosed) {
          emit(ProfileLogoutSuccess());
        }
      },
      ifRight: (message) {
        if (!isClosed) {
          emit(ProfileLogoutSuccess());
        }
      },
    );
  }
}
