import 'package:flutter/material.dart';
import 'package:town_pulse2/core/router/app_router.dart';
import 'package:town_pulse2/core/utils/app_theme.dart';
import 'package:town_pulse2/features/home/presentation/views/home_screen.dart';
// import 'package:town_pulse2/features/splash/presentation/
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
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
