import 'package:go_router/go_router.dart';
import 'package:town_pulse2/features/activity/presentation/views/details_dialog_activities.dart';
import 'package:town_pulse2/features/auth/presentation/view/forget_password_view.dart';
import 'package:town_pulse2/features/auth/presentation/view/sign_in_view.dart';
import 'package:town_pulse2/features/auth/presentation/view/sign_up_view.dart';
import 'package:town_pulse2/features/home/presentation/views/home_view.dart';
import 'package:town_pulse2/features/intro/presentation/view/intro_view.dart';
import 'package:town_pulse2/features/main_screen/presentation/view/my_activity_view.dart';
import 'package:town_pulse2/features/splash/presentation/view/splash_view.dart';

class AppRouter {
  static const splashView = '/';
  static const introScreen = '/introScreen';
  static const signInScreen = '/SignInView';
  static const signUpScreen = '/SignUpView';
  static const forgetPasswordScreen = '/forgetPasswordScreen';
  static const homeScreen = '/homeScreen';
  static const myActivityView = '/myActivityView';

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
    ],
  );
}
