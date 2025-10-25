// lib/features/main_screen/presentation/view/my_activity_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/widgets/shimmer_loading.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_state.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/delete_activity_card.dart';
import 'package:town_pulse2/features/main_screen/presentation/widgets/swipe_hint_card.dart'; // ✅ استيراد البطاقة الجديدة

class MyActivitiesView extends StatelessWidget {
  const MyActivitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ActivityCubit>().getMyActiviy();

    return BlocBuilder<ActivityCubit, ActivityState>(
      builder: (context, state) {
        if (state is ActivityLoading) {
          return const Center(child: ShimmerLoading());
        } else if (state is ActivityError) {
          return Center(child: Text(state.message));
        } else if (state is ActivityLoaded) {
          if (state.activities.isEmpty) {
            return const Center(child: Text('لا توجد أنشطة خاصة بك حالياً'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            child: ListView.builder(
              itemCount: state.activities.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const SwipeHintCard();
                }

                final activity = state.activities[index - 1];
                return DeleteAndUpdateActivityCard(activity: activity);
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
