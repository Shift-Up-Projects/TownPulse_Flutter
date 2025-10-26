import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/features/attedence/data/model/attendance_record_model.dart';
import 'package:town_pulse2/features/attedence/presentation/cubit/attedence_cubit.dart';

class BuildAttendeeTile extends StatelessWidget {
  const BuildAttendeeTile({
    super.key,
    required this.context,
    required this.attendee,
    required this.activityId,
  });

  final BuildContext context;
  final AttendanceRecord attendee;
  final String activityId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AttendanceCubit>();
    final currentStatus = attendee.status.toUpperCase();

    Color statusColor = AppColors.textMuted;
    if (currentStatus == 'PRESENT') {
      statusColor = AppColors.success;
    } else if (currentStatus == 'LATE') {
      statusColor = AppColors.accent;
    } else if (currentStatus == 'ABSENT') {
      statusColor = AppColors.error;
    }

    return ListTile(
      leading: CircleAvatar(
        // ignore: deprecated_member_use
        backgroundColor: statusColor.withOpacity(0.2),
        child: Text(
          attendee.user?.name[0].toUpperCase() ?? '?',
          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
        ),
      ),
      title: Text(
        attendee.user?.name ?? 'مستخدم مجهول',
        style: Styles.textStyle16,
      ),
      subtitle: Text(
        'الحالة: $currentStatus',
        style: TextStyle(color: statusColor),
      ),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert),
        onSelected: (String status) {
          cubit.updateAttendanceStatus(
            attendanceId: attendee.id,
            newStatus: status,
            activityId: activityId,
          );
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'present',
            child: Text('حاضر (Present)'),
          ),
          const PopupMenuItem<String>(
            value: 'late',
            child: Text('متأخر (Late)'),
          ),
          const PopupMenuItem<String>(
            value: 'absent',
            child: Text('غائب (Absent)'),
          ),
        ],
      ),
    );
  }
}
