import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:town_pulse2/core/utils/styles.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Town', style: Styles.GoogleFonts30).animate().slide(
            begin: Offset(-1, 0),
            end: Offset(0, 0),
            duration: 1.seconds,
          ),
          Text('Pulse', style: Styles.GoogleFonts30).animate().slide(
            begin: Offset(9, 0),
            end: Offset(0, 0),
            duration: 1.seconds,
          ),
        ],
      ),
    );
  }
}
