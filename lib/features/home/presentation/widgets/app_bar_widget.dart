import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:town_pulse2/core/router/app_router.dart';

const List<String> _titles = [
  'الرئيسية',
  'الانشطة التي قمت بإنشائها',
  'انشاء',
  'الملف الشخصي',
];

AppBar buildAppBar(int currentIndex, BuildContext context) {
  return AppBar(
    title: Text(_titles[currentIndex]),
    actions: [
      IconButton(
        onPressed: () {
          context.push(AppRouter.searchView);
        },
        icon: const Icon(Icons.search),
      ),
      IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
    ],
  );
}
