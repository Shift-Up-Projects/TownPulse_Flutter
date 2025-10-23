import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/core/router/app_router.dart';
import 'package:town_pulse2/core/utils/api_services.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/features/home/presentation/views/home_view.dart';
import 'package:town_pulse2/features/intro/presentation/view/intro_view.dart';

import 'package:town_pulse2/features/splash/presentation/widget/splash_view_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void initState() {
    super.initState();
    _checkAuthenAndNavigate();

    // You can add any initialization logic here if needed
  }

  Future<void> _checkAuthenAndNavigate() async {
    await Future.delayed(const Duration(seconds: 4));
    final token = CacheHelper.getData(key: 'token');
    if (token != null && token.toString().isNotEmpty) {
      Api.instance.setToken(token);
      if (!mounted) return;
      context.go(AppRouter.homeScreen);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => const HomeView()),
      // );
    } else {
      if (!mounted) return;
      context.go(AppRouter.introScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blueGrey[900],
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.bgPrimary, AppColors.bgSecondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SplashViewBody(),
      ),
    );
  }
}
