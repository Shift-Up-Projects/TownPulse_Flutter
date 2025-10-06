import 'package:flutter/material.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/core/router/app_router.dart';
import 'package:town_pulse2/core/utils/api_services.dart';
import 'package:town_pulse2/core/utils/app_theme.dart';
import 'package:town_pulse2/features/auth/presentation/view/forget_password_view.dart';
import 'package:town_pulse2/features/home/presentation/views/home_view.dart';
// import 'package:town_pulse2/features/splash/presentation/
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:town_pulse2/features/intro/presentation/view/intro_view.dart';
import 'package:town_pulse2/features/splash/presentation/view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Api.init();
  runApp(TownPulse());
}

class TownPulse extends StatelessWidget {
  const TownPulse({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'EG'),
      supportedLocales: const [Locale('ar', 'EG'), Locale('en', 'US')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: HomeScreen(),

      // theme: ThemeData.dark(),
      // themeMode: ThemeMode.light,
      // debugShowCheckedModeBanner: false,
      // routerConfig: AppRouter.router,
    );
  }
}
