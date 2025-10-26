// lib/features/attedence/presentation/view/my_attendance_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/core/widgets/shimmer_loading.dart';
import 'package:town_pulse2/core/widgets/showToast.dart';
import 'package:town_pulse2/features/attedence/presentation/cubit/attedence_cubit.dart';
import 'package:town_pulse2/features/attedence/presentation/widgets/build_dismissible_attendance_card.dart';
import 'package:town_pulse2/features/main_screen/presentation/widgets/swipe_hint_card.dart';

class MyAttendanceView extends StatefulWidget {
  const MyAttendanceView({super.key});

  @override
  State<MyAttendanceView> createState() => _MyAttendanceViewState();
}

class _MyAttendanceViewState extends State<MyAttendanceView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AttendanceCubit>().getMyAttendance());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سجل حضوري')),
      body: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceDeleted) {
            ShowToast(
              message: 'تم إلغاء الحضور بنجاح',
              state: toastState.success,
            );
          }
          if (state is AttendanceError) {
            ShowToast(message: state.message, state: toastState.error);
          }
        },
        builder: (context, state) {
          if (state is MyAttendanceLoading) {
            return const Center(child: ShimmerLoading());
          } else if (state is MyAttendanceLoaded) {
            if (state.records.isEmpty) {
              return Center(
                child: Text(
                  'لم تسجل حضورك في أي نشاط بعد',
                  style: Styles.textStyle18.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: ListView.builder(
                itemCount: state.records.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return SwipeHintCard();
                  }
                  final record = state.records[index - 1];
                  if (record.activity == null) return const SizedBox.shrink();

                  return BuildDismissibleAttendanceCard(record: record);
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
