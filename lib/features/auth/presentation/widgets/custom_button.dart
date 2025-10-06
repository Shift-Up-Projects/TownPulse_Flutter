import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        splashColor: AppColors.primary,
        child: Ink(
          height: 60,
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryDark,
          ),

          child: Container(
            // color: Colors.white,
            child: Center(child: Text(text)),
          ),
        ),
      ),
    );
  }
}
