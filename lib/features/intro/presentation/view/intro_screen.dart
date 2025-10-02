// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/features/intro/presentation/intro_pages.dart';
import 'package:town_pulse2/features/intro/presentation/widget/intro_screen_body.dart';
import 'package:town_pulse2/features/intro/presentation/widget/pointer_for_intro_screen.dart';
import 'package:town_pulse2/features/intro/presentation/widget/text_button_for_intro_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.bgSecondary, AppColors.bgPrimary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: introPages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return IntroScreenBody(
                    icon: introPages[index]["icon"],
                    text1: introPages[index]["title"],
                    text2: introPages[index]["subtitle"],
                  );
                },
              ),
            ),
            PointerForIntroScreen(currentIndex: currentIndex),
            TextButtonForIntroScreen(
              currentIndex: currentIndex,
              pageController: _pageController,
            ),
          ],
        ),
      ),
    );
  }
}
