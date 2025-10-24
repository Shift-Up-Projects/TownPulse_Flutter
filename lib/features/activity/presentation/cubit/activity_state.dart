import 'package:town_pulse2/features/activity/data/model/activity_model.dart';

abstract class ActivityState {}

class ActivityIntial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  final List<Activity> activities;
  ActivityLoaded(this.activities);
}

class ActivityError extends ActivityState {
  final String message;
  ActivityError(this.message);
}

class ActivityCreating extends ActivityState {}

class ActivityCreated extends ActivityState {
  final Activity activity;
  ActivityCreated(this.activity);

  List<Object?> get props => [activity];
}

class ActivityDeleted extends ActivityState {}

class ActivityUpdated extends ActivityState {}
