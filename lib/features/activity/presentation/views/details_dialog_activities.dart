import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/details_activities_body.dart';

import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/attedence/data/datasource/attendance_remote_data_source.dart';
import 'package:town_pulse2/features/attedence/data/repo/attedence_repo_impl.dart';
import 'package:town_pulse2/features/attedence/presentation/cubit/attedence_cubit.dart';

class DetailsDialogActivities extends StatelessWidget {
  final Activity activity;

  const DetailsDialogActivities({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AttendanceCubit(AttendanceRepoImpl(AttendanceRemoteDataSource())),
      child: DetailsActivitiesBody(activity: activity),
    );
  }
}
