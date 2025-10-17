import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/card_of_activities.dart';

class DeleteActivityCard extends StatelessWidget {
  const DeleteActivityCard({super.key, required this.activity});

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(activity.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        final confirm = await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('تأكيد الحذف'),
            content: const Text('هل أنت متأكد أنك تريد حذف هذا النشاط؟'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('حذف'),
              ),
            ],
          ),
        );
        return confirm ?? false;
      },
      onDismissed: (_) {
        context.read<ActivityCubit>().deleteActivity(activity.id!);
      },
      child: CardOfActivity(activity: activity),
    );
  }
}
