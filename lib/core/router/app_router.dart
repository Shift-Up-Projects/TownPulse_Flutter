import 'package:go_router/go_router.dart';
import 'package:town_pulse2/features/auth/presentation/view/sign_in_screen.dart';
import 'package:town_pulse2/features/intro/presentation/view/intro_screen.dart';
import 'package:town_pulse2/features/splash/presentation/view/splash_view.dart';

class AppRouter {
  static const splashView = '/';
  static const introScreen = '/introScreen';
  static const signInScreen = '/signInScreen';

  static final router = GoRouter(
    routes: [
      GoRoute(path: splashView, builder: (context, state) => SplashView()),
      GoRoute(path: introScreen, builder: (context, state) => IntroScreen()),
      GoRoute(path: signInScreen, builder: (context, state) => SignInScreen()),
    ],
  );
}
