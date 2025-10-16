import 'package:flutter/material.dart';
import 'package:town_pulse2/features/auth/presentation/widgets/custom_text_field.dart';

class ActivityTextFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descController;
  final TextEditingController locController;
  final TextEditingController mapUrlController;
  final TextEditingController priceController;
  final TextEditingController capacityController;

  const ActivityTextFields({
    super.key,
    required this.titleController,
    required this.descController,
    required this.locController,
    required this.mapUrlController,
    required this.priceController,
    required this.capacityController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          text: 'عنوان النشاط',
          prefixIcon: Icons.title,
          controller: titleController,
        ),
        SizedBox(height: 12),
        CustomTextField(
          text: 'وصف النشاط',
          prefixIcon: Icons.description,
          controller: descController,
        ),
        SizedBox(height: 12),
        CustomTextField(
          text: 'الموقع',
          prefixIcon: Icons.location_on,
          controller: locController,
        ),
        SizedBox(height: 12),
        CustomTextField(
          text: 'رابط الخريطة (اختياري)',
          prefixIcon: Icons.map,
          controller: mapUrlController,
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                text: 'السعر (اختياري)',
                prefixIcon: Icons.monetization_on,
                controller: priceController,
                // keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomTextField(
                text: 'عدد الحضور (اختياري)',
                prefixIcon: Icons.people,
                controller: capacityController,
                // keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
