import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:town_pulse2/core/router/app_router.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/core/utils/api_services.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  void _checkAuthenAndNavigate(BuildContext context) {
    final token = CacheHelper.getData(key: 'token');
    if (token != null && token.toString().isNotEmpty) {
      Api.instance.setToken(token as String);
      GoRouter.of(context).go(AppRouter.homeScreen);
    } else {
      GoRouter.of(context).go(AppRouter.introScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Pulse', style: Styles.textStyle30.copyWith(color: Colors.white))
              .animate()
              .slide(
                begin: Offset(9, 0),
                end: Offset(0, 0),
                duration: 1.5.seconds,
              )
              .then()
              .callback(
                callback: (value) {
                  _checkAuthenAndNavigate(context);
                },
              ),
          Text('Town', style: Styles.textStyle30).animate().slide(
            begin: Offset(-9, 0),
            end: Offset(0, 0),
            duration: 1.seconds,
          ),
        ],
      ),
    );
  }
}
