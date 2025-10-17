// lib/features/activity/presentation/views/create_activity/widgets/category_selector.dart
import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';

final Map<String, Map<String, Object>> defaultCategories = {
  'MUSIC': {'name': 'موسيقى', 'icon': Icons.music_note},
  'SPORTS': {'name': 'رياضة', 'icon': Icons.sports_soccer},
  'ART': {'name': 'فن', 'icon': Icons.brush},
  'EDUCATION': {'name': 'تعليم', 'icon': Icons.school},
  'BUSINESS': {'name': 'أعمال', 'icon': Icons.business_center},
  'TECHNOLOGY': {'name': 'تقنية', 'icon': Icons.computer},
  'FOOD': {'name': 'طعام', 'icon': Icons.fastfood},
  'TRAVEL': {'name': 'سفر', 'icon': Icons.flight_takeoff},
  'OTHER': {'name': 'أخرى', 'icon': Icons.more_horiz},
};

class CategorySelector extends StatelessWidget {
  final Map<String, Map<String, Object>> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelect;

  CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onSelect,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final key = categories.keys.elementAt(index);
          final item = categories[key]!;
          final isSelected = key == selectedCategory;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
            child: GestureDetector(
              onTap: () => onSelect(key),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item['icon'] as IconData,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.overlayWhite90,
                    size: 36,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item['name'] as String,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.overlayWhite90,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
