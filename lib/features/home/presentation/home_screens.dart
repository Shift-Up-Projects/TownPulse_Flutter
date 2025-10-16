import 'package:flutter/material.dart';
import 'package:town_pulse2/features/main_screen/presentation/view/create_activity_view.dart';
import 'package:town_pulse2/features/main_screen/presentation/view/main_screen.dart';

final List<Widget> screens = [
  const MainScreen(),
  const Center(child: Text('اكتشف')),
  CreateActivityView(),
  const Center(child: Text('المفضلة')),
  const Center(child: Text('الملف الشخصي')),
];
