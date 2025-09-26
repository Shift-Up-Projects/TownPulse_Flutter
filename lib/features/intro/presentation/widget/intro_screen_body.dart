import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/styles.dart';

class IntroScreenBody extends StatelessWidget {
  final String text1;
  final IconData icon;
  final String text2;
  const IntroScreenBody({
    super.key,
    required this.text1,
    required this.icon,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Spacer(flex: 1),
        CircleAvatar(
          maxRadius: 50,
          child: Icon(icon, size: 50),
          // backgroundColor: Colors.accents.,
        ),
        SizedBox(height: 20),

        Text(text1, style: Styles.textStyle30),
        SizedBox(height: 20),
        Text(
          text2,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: Styles.textStyle18,
        ),
        Spacer(flex: 1),
        // Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: Row(
        //     // spacing: 5,
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       TextButton(
        //         style: ButtonStyle(),
        //         onPressed: () {},
        //         child: Text('تخطي', style: Styles.textStyle18),
        //       ),
        //       TextButton(
        //         onPressed: () {},
        //         child: Text('التالي', style: Styles.textStyle18),
        //       ),
        //     ],
        //   ),
        // ),
        // Spacer(flex: 1),
      ],
    );
  }
}
