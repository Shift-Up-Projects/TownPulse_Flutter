import 'package:flutter/material.dart';

class ActivityCategory {
  final String key;
  final String label;
  final IconData icon;

  const ActivityCategory({
    required this.key,
    required this.label,
    required this.icon,
  });
}

const List<ActivityCategory> categoriesList = [
  ActivityCategory(key: 'ALL', label: 'الكل', icon: Icons.border_all_rounded),
  ActivityCategory(key: 'MUSIC', label: 'موسيقى', icon: Icons.music_note),
  ActivityCategory(key: 'SPORTS', label: 'رياضة', icon: Icons.sports_soccer),
  ActivityCategory(key: 'ART', label: 'فن', icon: Icons.brush),
  ActivityCategory(key: 'EDUCATION', label: 'تعليم', icon: Icons.school),
  ActivityCategory(
    key: 'BUSINESS',
    label: 'أعمال',
    icon: Icons.business_center,
  ),
  ActivityCategory(key: 'TECHNOLOGY', label: 'تقنية', icon: Icons.computer),
  ActivityCategory(key: 'FOOD', label: 'طعام', icon: Icons.fastfood),
  ActivityCategory(
    key: 'TRAVEL',
    label: 'سفر',
    icon: Icons.airplanemode_active,
  ),
  ActivityCategory(key: 'OTHER', label: 'أخرى', icon: Icons.more_horiz),
];
