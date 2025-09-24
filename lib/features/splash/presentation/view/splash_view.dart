import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/features/splash/presentation/widget/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey[900],
      body: SplashViewBody(),
    );
  }
}
