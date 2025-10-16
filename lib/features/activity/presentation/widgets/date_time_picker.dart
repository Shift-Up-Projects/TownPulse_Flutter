// lib/features/activity/presentation/views/create_activity/widgets/date_time_picker.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerRow extends StatelessWidget {
  final DateTime? start;
  final DateTime? end;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;

  const DateTimePickerRow({
    super.key,
    required this.start,
    required this.end,
    required this.onPickStart,
    required this.onPickEnd,
  });

  String fmt(DateTime? d) {
    if (d == null) return '-';
    return DateFormat('yyyy/MM/dd – HH:mm', 'ar').format(d);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onPickStart,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(start == null ? 'بداية النشاط' : fmt(start)),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: InkWell(
            onTap: onPickEnd,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.event, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(end == null ? 'نهاية النشاط' : fmt(end)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
