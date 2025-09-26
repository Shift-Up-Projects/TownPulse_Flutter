import 'package:flutter/material.dart';
import 'package:town_pulse2/core/router/app_router.dart';
// import 'package:town_pulse2/features/splash/presentation/view/splash_view.dart';

void main() {
  runApp(TownPulse());
}

class TownPulse extends StatelessWidget {
  const TownPulse({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
