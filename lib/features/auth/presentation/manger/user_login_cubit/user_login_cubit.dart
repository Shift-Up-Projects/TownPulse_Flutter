import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:town_pulse2/features/auth/data/repo/auth_repo.dart';

part 'user_login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  UserLoginCubit(this.authRepo) : super(UserLoginInitial());
  final AuthRepo authRepo;
  static UserLoginCubit get(context)=>BlocProvider.of(context);
  Future<void> userLogin({required String userName , required String password})async{
    emit(UserLoginLoadingState());
    final result=await authRepo.userSignIn(email: userName, password: password);
    result.fold(ifLeft: (failure){
      emit(UserLoginFailureState(errorMessage: failure.errorMessage));
    }, ifRight: (message){
      emit(UserLoginSuccessfullyState(message: message));
    });
  }

}
