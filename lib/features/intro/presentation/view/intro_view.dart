import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/features/intro/presentation/intro_pages.dart';
import 'package:town_pulse2/features/intro/presentation/widget/intro_view_body.dart';
import 'package:town_pulse2/features/intro/presentation/widget/pointer_for_intro_screen.dart';
import 'package:town_pulse2/features/intro/presentation/widget/text_button_for_intro_screen.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
      ),
    );
  }
}
