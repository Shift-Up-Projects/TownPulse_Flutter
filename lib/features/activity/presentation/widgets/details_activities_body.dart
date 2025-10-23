import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/core/widgets/shimmer_loading.dart';
import 'package:town_pulse2/features/activity/data/category_consts.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/attedence/presentation/cubit/attedence_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsActivitiesBody extends StatelessWidget {
  const DetailsActivitiesBody({super.key, required this.activity});

  final Activity activity;
  void _openMap(String url, BuildContext context) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('لا يمكن فتح الرابط')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.title ?? '',
                style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text("الفئة: ${activity.category}", style: Styles.textStyle16),
              const SizedBox(height: 8),
              Text("الوصف: ${activity.description}", style: Styles.textStyle16),
              const SizedBox(height: 8),
              Text("الموقع: ${activity.location}", style: Styles.textStyle16),
              const SizedBox(height: 8),
              if (activity.mapUrl != null && activity.mapUrl!.isNotEmpty)
                InkWell(
                  onTap: () => _openMap("https://" + activity.mapUrl!, context),
                  child: Text(
                    "شاهد على الخريطة",
                    style: Styles.textStyle16.copyWith(color: Colors.blue),
                  ),
                ),
              const SizedBox(height: 8),
              Text(
                "التاريخ: ${activity.startDate != null ? "${activity.startDate!.day}/${activity.startDate!.month}/${activity.startDate!.year}" : ""} - ${activity.endDate != null ? "${activity.endDate!.day}/${activity.endDate!.month}/${activity.endDate!.year}" : ""}",
                style: Styles.textStyle16,
              ),
              const SizedBox(height: 8),
              Text(
                "السعر: ${activity.price != null ? activity.price!.value.toString() : 'مجاني'}",
              ),

              const SizedBox(height: 8),
              Text(
                "السعة: ${activity.capacity ?? 'غير محدد'}",
                style: Styles.textStyle16,
              ),
              const SizedBox(height: 8),
              Text(
                "الساعة: ${activity.startDate?.hour ?? 'غير محدد'}:${activity.startDate?.minute.toString().padLeft(2, '0') ?? '00'} - ${activity.endDate?.hour ?? 'غير محدد'}:${activity.endDate?.minute.toString().padLeft(2, '0') ?? '00'}",
                style: Styles.textStyle16,
              ),
              const SizedBox(height: 8),
              Text(
                "الحالة: ${activity.status ?? 'غير محدد'}",
                style: Styles.textStyle16,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("اغلاق"),
                    ),
                  ),
                  BlocConsumer<AttendanceCubit, AttendanceState>(
                    listener: (context, state) {
                      if (state is AttendanceSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تم تسجيل حضورك بنجاح ✅'),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      } else if (state is AttendanceError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: AppColors.statusCancelled,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AttendanceLoading) return ShimmerContainer();
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed: () {
                            final userId = CacheHelper.getData(key: 'user_id');
                            log('🧍 userId: $userId');
                            log('🎯 activityId: ${activity.id}');
                            context.read<AttendanceCubit>().markAttendance(
                              userId: userId,
                              activityId: activity.id!,
                            );
                          },
                          child: const Text("حجز الآن"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
