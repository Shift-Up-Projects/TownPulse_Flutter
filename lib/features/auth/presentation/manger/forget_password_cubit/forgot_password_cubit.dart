import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepo authRepo;

  ForgotPasswordCubit(this.authRepo) : super(ForgotPasswordInitial());

  static ForgotPasswordCubit get(context) => BlocProvider.of(context);

  Future<void> forgotPassword({required String email}) async {
    emit(ForgotPasswordLoading());
    final result = await authRepo.forgotPassword(email: email);

    result.fold(
      ifLeft: (failure) {
        if (!isClosed) {
          emit(ForgotPasswordError(failure.errorMessage));
        }
      },
      ifRight: (message) {
        if (!isClosed) {
          emit(ForgotPasswordSuccess(message));
        }
      },
    );
  }
}
