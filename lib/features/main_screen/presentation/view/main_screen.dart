import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/utils/styles.dart';
import 'package:town_pulse2/core/widgets/shimmer_loading.dart';
import 'package:town_pulse2/features/activity/get_near_by_gio.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_state.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/card_of_activities.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/horizontal_list_of_main_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  void _showDistanceDialog(BuildContext context) {
    final TextEditingController distanceController = TextEditingController(
      text: '10',
    );
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('تحديد نصف القطر'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: distanceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'المسافة بالكيلومتر (كم)',
              suffixText: 'كم',
            ),
            validator: (value) {
              if (value == null ||
                  int.tryParse(value) == null ||
                  int.parse(value) <= 0) {
                return 'أدخل مسافة صحيحة (أكبر من صفر)';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final distance = int.parse(distanceController.text);
                Navigator.pop(ctx);
                getNearby(context, distance);
              }
            },
            child: const Text('بحث'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  'الفئات',
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(onPressed: () {}, child: Text('عرض الكل')),
              ],
            ),
            HorizontalListOfMainScreen(),

            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'الانشطة المتاحة',
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),
                TextButton(
                  onPressed: () async {
                    _showDistanceDialog(context);
                  },
                  child: Text(
                    ' الانشطة القريبة',
                    style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<ActivityCubit, ActivityState>(
              builder: (context, state) {
                if (state is ActivityLoading) {
                  return Center(child: ShimmerLoading());
                } else if (state is ActivityError) {
                  return Center(child: Text(state.message));
                } else if (state is ActivityLoaded) {
                  final activities = state.activities;
                  if (activities.isEmpty) {
                    return Center(child: Text('لا توجد انشطة متاحة حاليا'));
                  }

                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      final activity = activities[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: CardOfActivity(activity: activity),
                      );
                    },
                  );
                }

                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
