import 'package:flutter/material.dart';
import 'package:town_pulse2/features/intro/presentation/intro_pages.dart';

class PointerForIntroScreen extends StatelessWidget {
  const PointerForIntroScreen({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        introPages.length,
        (index) => Container(
          margin: const EdgeInsets.all(4),
          width: currentIndex == index ? 12 : 8,
          height: currentIndex == index ? 12 : 8,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.white : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
