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
}
