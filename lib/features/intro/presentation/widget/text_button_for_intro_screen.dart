import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:town_pulse2/core/router/app_router.dart';
import 'package:town_pulse2/features/intro/presentation/intro_pages.dart';

class TextButtonForIntroScreen extends StatelessWidget {
  const TextButtonForIntroScreen({
    super.key,
    required this.currentIndex,
    required PageController pageController,
  }) : _pageController = pageController;

  final int currentIndex;
  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              context.go(AppRouter.forgetPasswordScreen);
            },
            child: const Text("تخطي", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              if (currentIndex < introPages.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              } else {
                context.go(AppRouter.forgetPasswordScreen);
              }
            },
            child: Text(
              currentIndex == introPages.length - 1 ? "ابدأ" : "التالي",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
