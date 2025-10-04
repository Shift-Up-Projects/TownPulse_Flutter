import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';

const List<String> _titles = [
  'الرئيسية',
  'اكتشف',
  'انشاء',
  'المفضلة',
  'الملف الشخصي',
];

AppBar buildAppBar(int currentIndex) {
  return AppBar(
    title: Text(_titles[currentIndex]),
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
    ],
  );
}
