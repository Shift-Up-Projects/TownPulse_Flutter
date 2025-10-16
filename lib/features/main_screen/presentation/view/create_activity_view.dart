// lib/features/activity/presentation/views/create_activity/create_activity_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_state.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/activity_text_fields.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/category_selector.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/create_button.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/date_time_picker.dart';

class CreateActivityView extends StatefulWidget {
  const CreateActivityView({super.key});

  @override
  State<CreateActivityView> createState() => _CreateActivityViewState();
}

class _CreateActivityViewState extends State<CreateActivityView> {
  final _formKey = GlobalKey<FormState>();

  // controllers
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final locController = TextEditingController();
  final mapUrlController = TextEditingController();
  final priceController = TextEditingController();
  final capacityController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  String selectedCategory = 'MUSIC';
  bool isLoading = false;

  Future<void> pickDateTime(BuildContext ctx, bool isStart) async {
    final pickedDate = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2030),
      locale: const Locale('ar'),
    );
    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: ctx,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    final full = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );
    setState(() {
      if (isStart)
        startDate = full;
      else
        endDate = full;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    // validation: start < end (if provided)
    if (startDate != null && endDate != null && startDate!.isAfter(endDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تأكد من أن تاريخ البداية قبل النهاية')),
      );
      return;
    }

    final activityData = {
      "title": titleController.text.trim(),
      "description": descController.text.trim(),
      "location": locController.text.trim(),
      "map_url": mapUrlController.text.trim(),
      "start_date": startDate?.toUtc().toIso8601String(),
      "end_date": endDate?.toUtc().toIso8601String(),
      "price": double.tryParse(priceController.text) ?? 0,
      "capacity": int.tryParse(capacityController.text) ?? 0,
      "category": selectedCategory,
    };

    // استدعاء الكيوبت
    context.read<ActivityCubit>().createActivity(activityData);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityCubit, ActivityState>(
      listener: (context, state) {
        if (state is ActivityCreating) {
          setState(() => isLoading = true);
        } else {
          setState(() => isLoading = false);
        }

        if (state is ActivityCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم إنشاء النشاط بنجاح')),
          );
          Navigator.pop(context, true); // ارجع مع نتيجة ناجحة
        } else if (state is ActivityError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ActivityTextFields(
                  titleController: titleController,
                  descController: descController,
                  locController: locController,
                  mapUrlController: mapUrlController,
                  priceController: priceController,
                  capacityController: capacityController,
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'اختر الفئة:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                CategorySelector(
                  selectedCategory: selectedCategory,
                  onSelect: (val) => setState(() => selectedCategory = val),
                  categories: defaultCategories,
                ),
                const SizedBox(height: 16),
                DateTimePickerRow(
                  start: startDate,
                  end: endDate,
                  onPickStart: () => pickDateTime(context, true),
                  onPickEnd: () => pickDateTime(context, false),
                ),
                const SizedBox(height: 24),
                CreateButton(loading: isLoading, onPressed: _submit),
              ],
            ),
          ),
        );
      },
    );
  }
}
