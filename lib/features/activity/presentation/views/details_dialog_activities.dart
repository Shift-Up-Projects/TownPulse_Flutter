// lib/features/activity/presentation/views/details_dialog_activities.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/details_activities_body.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/attedence/data/datasource/attendance_remote_data_source.dart';
import 'package:town_pulse2/features/attedence/data/repo/attedence_repo_impl.dart';
import 'package:town_pulse2/features/attedence/presentation/cubit/attedence_cubit.dart';
import 'package:town_pulse2/features/review/data/datasource/review_remote_data_source.dart';
import 'package:town_pulse2/features/review/data/repo/review_repo_impl.dart';
import 'package:town_pulse2/features/review/presentation/cubit/review_cubit.dart';

class DetailsDialogActivities extends StatelessWidget {
  final Activity activity;

  const DetailsDialogActivities({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AttendanceCubit(AttendanceRepoImpl(AttendanceRemoteDataSource())),
        ),

        BlocProvider(
          create: (context) =>
              ReviewCubit(ReviewRepoImpl(ReviewRemoteDataSource()))
                ..fetchReviews(activity.id!),
        ),
      ],
      child: DetailsActivitiesBody(activity: activity),
    );
  }
}
