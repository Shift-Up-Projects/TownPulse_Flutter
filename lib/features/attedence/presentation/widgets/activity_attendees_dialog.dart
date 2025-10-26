import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/core/widgets/shimmer_loading.dart';
import 'package:town_pulse2/core/widgets/showToast.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/attedence/data/repo/attedence_repo_impl.dart';
import 'package:town_pulse2/features/attedence/data/datasource/attendance_remote_data_source.dart';
import 'package:town_pulse2/features/attedence/presentation/cubit/attedence_cubit.dart';
import 'package:town_pulse2/features/attedence/presentation/widgets/build_attendee_tile.dart';
import 'package:town_pulse2/features/attedence/presentation/widgets/build_statistics.dart';

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
                          BuildStatistics(
                            stats: stats,
                            capacity: activity.capacity,
                          ),
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
                                return BuildAttendeeTile(
                                  context: context,
                                  attendee: attendee,
                                  activityId: activity.id!,
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
}
