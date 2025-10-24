import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/widgets/showToast.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_state.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/activity_text_fields.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/category_selector.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/date_time_picker.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/create_button.dart';

class EditActivityView extends StatefulWidget {
  final Activity activity;
  const EditActivityView({super.key, required this.activity});

  @override
  State<EditActivityView> createState() => _EditActivityViewState();
}

class _EditActivityViewState extends State<EditActivityView> {
  final _formKey = GlobalKey<FormState>();

  // controllers
  late TextEditingController titleController;
  late TextEditingController descController;
  late TextEditingController locController;
  late TextEditingController mapUrlController;
  late TextEditingController priceController;
  late TextEditingController capacityController;

  DateTime? startDate;
  DateTime? endDate;
  late String selectedCategory;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    final a = widget.activity;

    titleController = TextEditingController(text: a.title ?? '');
    descController = TextEditingController(text: a.description ?? '');
    locController = TextEditingController(text: a.location ?? '');
    mapUrlController = TextEditingController(text: a.mapUrl ?? '');
    priceController = TextEditingController(text: a.price?.numberDecimal ?? '');
    capacityController = TextEditingController(
      text: a.capacity?.toString() ?? '',
    );

    selectedCategory = a.category ?? 'OTHER';
    startDate = a.startDate;
    endDate = a.endDate;
  }

  Future<void> pickDateTime(BuildContext ctx, bool isStart) async {
    final pickedDate = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
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

    if (startDate != null && endDate != null && startDate!.isAfter(endDate!)) {
      ShowToast(
        message: 'تاريخ البداية يجب أن يكون قبل النهاية',
        state: toastState.error,
      );
      return;
    }

    final updatedData = {
      "title": titleController.text.trim(),
      "description": descController.text.trim(),
      "location": locController.text.trim(),
      "map_url": mapUrlController.text.trim(),
      "latitude": widget.activity.latitude,
      "longitude": widget.activity.longitude,
      "start_date": startDate?.toUtc().toIso8601String(),
      "end_date": endDate?.toUtc().toIso8601String(),
      "price": double.tryParse(priceController.text) ?? 0,
      "capacity": int.tryParse(capacityController.text) ?? 0,
      "category": selectedCategory,
    };

    context.read<ActivityCubit>().updateActivity(
      widget.activity.id!,
      updatedData,
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityCubit, ActivityState>(
      listener: (context, state) {
        if (state is ActivityLoading)
          setState(() => isLoading = true);
        else
          setState(() => isLoading = false);

        if (state is ActivityUpdated) {
          ShowToast(
            message: 'تم تحديث النشاط بنجاح',
            state: toastState.success,
          );
          Navigator.pop(context, true);
        } else if (state is ActivityError) {
          ShowToast(message: state.message, state: toastState.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('تعديل النشاط')),
          body: SingleChildScrollView(
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
                  CreateButton(
                    loading: isLoading,
                    onPressed: _submit,
                    text: 'تحديث النشاط',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
