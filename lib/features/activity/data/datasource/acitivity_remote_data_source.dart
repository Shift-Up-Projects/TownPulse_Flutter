import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:town_pulse2/core/utils/api_services.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';

class AcitivityRemoteDataSource {
  final Api _api = Api.instance;
  final Dio _dio = Dio();
  final String _token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4ZDAyMzUzN2ZjN2IxNjFmMGYzOTlmZCIsImlhdCI6MTc2MDUyMDk4MywiZXhwIjoxNzY4Mjk2OTgzfQ.bZLf37qkRCcghLuTylqnNB6HiYcC9LD9KVRdVJUD2JA";
  Future<List<Activity>> getAllActivity(String? token, String? category) async {
    try {
      final query = (category != null && category != 'ALL')
          ? {'category': category}
          : null;

      final Response response = await _api.get(
        url: 'activity',
        token: token,
        query: query,
      );
      log('${response.data}');

      final data = response.data['data'];
      if (data == null) return [];

      return (data as List).map((json) => Activity.fromJson(json)).toList();
    } catch (e) {
      throw Exception('فشل في جلب الأنشطة: $e');
    }
  }

  Future<Activity> createActivity({
    required String token,
    required Map<String, dynamic> activityData,
  }) async {
    try {
      final Response response = await _api.post(
        url: 'activity',
        token: token,
        body: activityData,
      );
      final data = response.data['data'];
      return Activity.fromJson(data as Map<String, dynamic>);
    } on Exception catch (e) {
      throw Exception('فشل في إنشاء النشاط: $e');
    }
  }

  Future<Response> getMyActivities(String token) async {
    return await Api.instance.get(url: 'activity/my/activities', token: token);
  }

  Future<Response> deleteActivity(String id, String token) async {
    return await Api.instance.delete(url: 'activity/$id', token: token);
  }

  Future<Response> updateActivity(
    String id,
    Map<String, dynamic> activityData,
    String token,
  ) async {
    return await Api.instance.put(
      url: 'activity/$id',
      body: activityData,
      token: token,
    );
  }

  Future<List<Activity>> getNearByActivities({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await Api.instance.get(
        url: 'activity/near?latitude=$latitude&longitude=$longitude',
      );
      if (response.statusCode == 200 && response.data['isSuccess'] == true) {
        final List<dynamic> data = response.data['data'];
        return data.map((e) => Activity.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log('❌ Error fetching nearby activities: $e');
      return [];
    }
  }

  Future<Response> searchActivities(String query) async {
    return await Api.instance.get(
      url: 'activity',
      query: {'?q': query},
      token: _api.token,
    );
  }
}
