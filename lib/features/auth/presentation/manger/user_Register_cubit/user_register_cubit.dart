import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo.dart';

part 'user_register_state.dart';

class UserRegisterCubit extends Cubit<UserRegisterState> {
  UserRegisterCubit(this.authRepo) : super(UserRegisterInitial());
  final AuthRepo authRepo;

  static UserRegisterCubit get(context) => BlocProvider.of(context);

  Future<void> userRegister({
    required String userName,
    required String email,
    required String password,
  }) async {
    emit(UserRegisterLoadingState());
    final result = await authRepo.userSignUp(
      userName: userName,
      email: email,
      password: password,
    );
    result.fold(
      ifLeft: (failure) {
        emit(UserRegisterFailureState(errorMessage: failure.errorMessage));
      },
      ifRight: (message) {
        emit(UserRegisterSuccessfullyState(message: message));
      },
    );
  }
}
