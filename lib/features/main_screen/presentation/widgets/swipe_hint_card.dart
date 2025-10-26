// lib/features//presentation/widgets/swipe_hint_card.dart
import 'package:flutter/material.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';

class SwipeHintCard extends StatefulWidget {
  const SwipeHintCard({super.key});

  @override
  State<SwipeHintCard> createState() => _SwipeHintCardState();
}

class _SwipeHintCardState extends State<SwipeHintCard> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return const SizedBox.shrink();
    }

    return Dismissible(
      key: const ValueKey('swipe_hint_key'),
      direction: DismissDirection.horizontal,
      onDismissed: (_) {
        setState(() {
          _isVisible = false;
        });
      },
      background: Container(
        color: AppColors.success,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.edit, color: Colors.white, size: 28),
      ),
      secondaryBackground: Container(
        color: AppColors.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.delete, color: Colors.white, size: 28),
      ),
      child: Card(
        color: AppColors.bgSecondary,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: ListTile(
          leading: const Icon(Icons.swipe, color: AppColors.primary),
          title: Text(
            'تلميح: اسحب البطاقة',
            style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '⬅️ اسحب لليسار: تعديل النشاط.',
                style: TextStyle(color: AppColors.textMuted),
              ),
              Text(
                '➡️ اسحب لليمين: حذف النشاط.',
                style: TextStyle(color: AppColors.textMuted),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close, color: AppColors.textMuted),
            onPressed: () {
              setState(() {
                _isVisible = false;
              });
            },
          ),
        ),
      ),
    );
  }
}
