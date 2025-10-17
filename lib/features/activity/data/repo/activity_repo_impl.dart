import 'dart:developer';

import 'package:dart_either/src/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:town_pulse2/core/errors/failure.dart';
import 'package:town_pulse2/features/activity/data/datasource/acitivity_remote_data_source.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/activity/data/repo/activity_repo.dart';

class ActivityRepoImpl implements ActivityRepo {
  final AcitivityRemoteDataSource remoteDataSource;
  ActivityRepoImpl(this.remoteDataSource);
  @override
  Future<List<Activity>> getAllActivity(String? token, String? category) async {
    return await remoteDataSource.getAllActivity(token, category);
  }

  @override
  Future<Activity> createActivity({
    required String token,
    required Map<String, dynamic> activityData,
  }) {
    return remoteDataSource.createActivity(
      token: token,
      activityData: activityData,
    );
  }

  Future<List<Activity>> getMyActivities(String token) async {
    try {
      final response = await remoteDataSource.getMyActivities(token);
      final rawData = response.data['data'];

      if (rawData == null) return [];

      List<dynamic> dataList;

      if (rawData is Map<String, dynamic> &&
          rawData.containsKey('activities')) {
        dataList = rawData['activities'];
      } else if (rawData is List) {
        dataList = rawData;
      } else {
        dataList = [];
      }

      final activities = dataList.map((e) => Activity.fromJson(e)).toList();
      return activities;
    } on DioException catch (e) {
      throw Exception('فشل في الاتصال بالسيرفر: ${e.message}');
    } catch (e) {
      throw Exception('خطأ غير متوقع: $e');
    }
  }
}
