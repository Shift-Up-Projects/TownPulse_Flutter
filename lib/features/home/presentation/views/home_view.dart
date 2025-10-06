import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:town_pulse2/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:town_pulse2/features/home/presentation/widgets/home_screens.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(_currentIndex),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: screens[_currentIndex],
    );
  }
}
