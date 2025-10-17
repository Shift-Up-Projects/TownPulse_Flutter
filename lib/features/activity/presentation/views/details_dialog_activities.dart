import 'package:flutter/material.dart';
import 'package:town_pulse2/features/activity/presentation/widgets/details_activities_body.dart';

import 'package:town_pulse2/features/activity/data/model/activity_model.dart';

class DetailsDialogActivities extends StatelessWidget {
  final Activity activity;

  const DetailsDialogActivities({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return DetailsActivitiesBody(activity: activity);
  }
}
