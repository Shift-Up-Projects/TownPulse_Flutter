import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/styles.dart';

class BuildStatistics extends StatelessWidget {
  const BuildStatistics({
    super.key,
    required this.stats,
    required this.capacity,
  });

  final Map<String, dynamic> stats;
  final int? capacity;

  @override
  Widget build(BuildContext context) {
    final total = stats['total_attendance'] ?? 0;
    final rate = stats['attendance_rate'] ?? '0.00';
    final breakdown = stats['status_breakdown'] as Map<String, dynamic>? ?? {};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الإحصائيات:',
          style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('الإجمالي: $total', style: Styles.textStyle14),
            Text('السعة: ${capacity ?? 'غير محدد'}', style: Styles.textStyle14),
          ],
        ),
        Text('نسبة الحضور: $rate%', style: Styles.textStyle14),
        if (breakdown.isNotEmpty)
          Wrap(
            spacing: 8,
            children: breakdown.entries
                .map(
                  (e) => Chip(
                    label: Text(
                      '${e.key}: ${e.value}',
                      style: Styles.textStyle14,
                    ),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }
}
