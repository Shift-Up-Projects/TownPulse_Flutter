import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:town_pulse2/core/utils/app_colors.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';

class DetailsDialogActivities extends StatelessWidget {
  final Activity activity;

  const DetailsDialogActivities({super.key, required this.activity});

  // دالة لفتح الرابط
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
                  onTap: () => _openMap(activity.mapUrl!, context),
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("حجز الآن"),
                    ),
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
