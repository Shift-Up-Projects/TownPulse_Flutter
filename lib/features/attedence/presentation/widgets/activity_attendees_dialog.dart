// lib/features/attedence/presentation/widgets/activity_attendees_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/core/widgets/shimmer_loading.dart';
import 'package:town_pulse2/core/widgets/showToast.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/attedence/data/model/attendance_record_model.dart';
import 'package:town_pulse2/features/attedence/data/repo/attedence_repo_impl.dart';
import 'package:town_pulse2/features/attedence/data/datasource/attendance_remote_data_source.dart';
import 'package:town_pulse2/features/attedence/presentation/cubit/attedence_cubit.dart';

class ActivityAttendeesDialog extends StatelessWidget {
  final Activity activity;

  const ActivityAttendeesDialog({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AttendanceCubit(AttendanceRepoImpl(AttendanceRemoteDataSource()))
            ..fetchActivityAttendees(activity.id!),

      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: const BoxConstraints(maxHeight: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'حضور: ${activity.title}',
                style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                child: BlocConsumer<AttendanceCubit, AttendanceState>(
                  listener: (context, state) {
                    if (state is AttendanceError) {
                      ShowToast(
                        message: state.message,
                        state: toastState.error,
                      );
                    } else if (state is AttendanceUpdatedSuccessfully) {
                      ShowToast(
                        message: state.message,
                        state: toastState.success,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ActivityAttendeesLoading ||
                        state is AttendanceUpdating) {
                      return const Center(child: ShimmerLoading());
                    } else if (state is ActivityAttendeesLoaded) {
                      final attendees = state.attendees;
                      final stats = state.statistics;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStatistics(stats, activity.capacity),
                          const SizedBox(height: 10),
                          Text(
                            'قائمة الحضور (${attendees.length})',
                            style: Styles.textStyle16.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const Divider(height: 5),
                          Expanded(
                            child: ListView.builder(
                              itemCount: attendees.length,
                              itemBuilder: (context, index) {
                                final attendee = attendees[index];
                                return _buildAttendeeTile(
                                  context,
                                  attendee,
                                  activity.id!,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (state is AttendanceError) {
                      return Center(
                        child: Text('خطأ في جلب الحضور: ${state.message}'),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('إغلاق'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendeeTile(
    BuildContext context,
    AttendanceRecord attendee,
    String activityId,
  ) {
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
        backgroundColor: statusColor.withOpacity(0.2),
        child: Text(
          attendee.user?.name?[0].toUpperCase() ?? '?',
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

  Widget _buildStatistics(Map<String, dynamic> stats, int? capacity) {
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
