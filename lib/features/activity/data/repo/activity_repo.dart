import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:town_pulse2/core/errors/failure.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';

abstract class ActivityRepo {
  Future<List<Activity>> getAllActivity(String? token, String? category);
  Future<Activity> createActivity({
    required String token,
    required Map<String, dynamic> activityData,
  });
  Future<List<Activity>> getMyActivities(String token);
  Future<void> deleteActivity(String id, String token);
  Future<void> updateActivity(
    String id,
    Map<String, dynamic> activityData,
    String token,
  );
  Future<List<Activity>> getNearbyActivities({
    required double latitude,
    required double longitude,
  });
  Future<List<Activity>> searchActivities(String query);
}
