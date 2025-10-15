import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/features/activity/data/repo/activity_repo.dart';
import 'package:town_pulse2/features/activity/data/repo/activity_repo_impl.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/features/home/presentation/widgets/app_bar_widget.dart';
import 'package:town_pulse2/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:town_pulse2/features/home/presentation/home_screens.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  void _ref(BuildContext context) {
    context.read<ActivityCubit>().fetchAllActivity();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _ref(context),
      child: Scaffold(
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
      ),
    );
  }
}
