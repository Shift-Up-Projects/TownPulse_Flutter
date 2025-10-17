import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/widgets/shimmer_loading.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_cubit.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_state.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/card_of_activities.dart';

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
              itemCount: state.activities.length,
              itemBuilder: (context, index) =>
                  CardOfActivity(activity: state.activities[index]),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
