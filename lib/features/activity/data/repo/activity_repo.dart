import 'package:town_pulse2/features/activity/data/model/activity_model.dart';

abstract class ActivityRepo {
  Future<List<Activity>> getAllActivity(String? token, String? category);
  Future<Activity> createActivity({
    required String token,
    required Map<String, dynamic> activityData,
  });
}
