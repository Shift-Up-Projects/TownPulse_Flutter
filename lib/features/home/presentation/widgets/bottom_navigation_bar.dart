import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final List<String> _titles = const [
    'الرئيسية',
    'نشاطاتي',
    'انشاء',
    'الملف الشخصي',
  ];

  final List<IconData> _icons = const [
    Icons.home,
    Icons.explore,
    Icons.add_box,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: AppColors.bgSecondary,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: List.generate(
        _titles.length,
        (index) => BottomNavigationBarItem(
          icon: Icon(_icons[index]),
          label: _titles[index],
        ),
      ),
    );
  }
}
