import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/card_of_activities.dart';
import 'package:town_pulse2/features/attedence/data/model/attendance_record_model.dart';
import 'package:town_pulse2/features/attedence/presentation/cubit/attedence_cubit.dart';

class BuildDismissibleAttendanceCard extends StatelessWidget {
  const BuildDismissibleAttendanceCard({super.key, required this.record});
  final AttendanceRecord record;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(record.id),
      background: Container(color: Colors.transparent),
      direction: DismissDirection.endToStart,
      secondaryBackground: Container(
        color: AppColors.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.cancel, color: Colors.white),
            SizedBox(width: 8),
            Text('إلغاء الحضور', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final confirm = await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('إلغاء الحضور'),
              content: const Text(
                'هل أنت متأكد من إلغاء تسجيل حضورك لهذا النشاط؟',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('إلغاء'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                  ),
                  child: const Text('نعم، إلغاء'),
                ),
              ],
            ),
          );
          if (confirm == true) {
            context.read<AttendanceCubit>().deleteAttendance(record.id);
            return true;
          }
          return false;
        }
        return false;
      },
      child: CardOfActivity(activity: record.activity!),
    );
  }
}
