import 'package:flutter/material.dart';
import 'package:town_pulse/features/splash/presentation/view/splash_view.dart';

void main() {
  runApp(TownPulse());
}

class TownPulse extends StatelessWidget {
  const TownPulse({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: SplashView(),
    );
  }
}
