import 'package:flutter/material.dart';

const List<String> _titles = [
  'الرئيسية',
  'اكتشف',
  'نشاطاتي',
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
