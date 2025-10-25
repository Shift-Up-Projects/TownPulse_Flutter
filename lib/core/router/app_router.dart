import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:town_pulse2/features/activity/presentation/views/details_dialog_activities.dart';
import 'package:town_pulse2/features/activity/presentation/views/search_view.dart';
import 'package:town_pulse2/features/attedence/data/datasource/attendance_remote_data_source.dart';
import 'package:town_pulse2/features/attedence/data/repo/attedence_repo_impl.dart';
import 'package:town_pulse2/features/attedence/presentation/cubit/attedence_cubit.dart';
import 'package:town_pulse2/features/attedence/presentation/screens/my_attendence_view.dart';
import 'package:town_pulse2/features/auth/data/model/user_model.dart';
import 'package:town_pulse2/features/auth/presentation/view/forget_password_view.dart';
import 'package:town_pulse2/features/auth/presentation/view/sign_in_view.dart';
import 'package:town_pulse2/features/auth/presentation/view/sign_up_view.dart';
import 'package:town_pulse2/features/home/presentation/views/home_view.dart';
import 'package:town_pulse2/features/intro/presentation/view/intro_view.dart';
import 'package:town_pulse2/features/main_screen/presentation/view/my_activity_view.dart';
import 'package:town_pulse2/features/profile/presentation/views/update_password_view.dart';
import 'package:town_pulse2/features/profile/presentation/views/update_profile_view.dart';
import 'package:town_pulse2/features/splash/presentation/view/splash_view.dart';

class AppRouter {
  static const splashView = '/';
  static const introScreen = '/introScreen';
  static const signInScreen = '/SignInView';
  static const signUpScreen = '/SignUpView';
  static const forgetPasswordScreen = '/forgetPasswordScreen';
  static const homeScreen = '/homeScreen';
  static const myActivityView = '/myActivityView';
  static const updateProfileView = '/updateProfileView';
  static const updatePasswordView = '/updatePasswordView';
  static const searchView = '/searchView';
  static const myAttendanceView = '/myAttendenceView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: splashView, builder: (context, state) => SplashView()),

      GoRoute(path: signUpScreen, builder: (context, state) => SignUpView()),
      GoRoute(path: introScreen, builder: (context, state) => IntroView()),
      GoRoute(path: signInScreen, builder: (context, state) => SignInView()),
      GoRoute(
        path: myActivityView,
        builder: (context, state) => MyActivitiesView(),
      ),

      GoRoute(
        path: forgetPasswordScreen,
        builder: (context, state) => ForgetPasswordView(),
      ),
      GoRoute(path: homeScreen, builder: (context, state) => HomeView()),
      GoRoute(
        path: updatePasswordView,
        builder: (context, state) => UpdatePasswordView(),
      ),
      GoRoute(
        path: updateProfileView,
        builder: (context, state) =>
            UpdateProfileView(user: state.extra as User),
      ),
      GoRoute(path: searchView, builder: (context, state) => SearchView()),
      GoRoute(
        path: myAttendanceView,
        builder: (context, state) => BlocProvider(
          create: (context) =>
              AttendanceCubit(AttendanceRepoImpl(AttendanceRemoteDataSource())),
          child: MyAttendanceView(),
        ),
      ),
    ],
  );
}
