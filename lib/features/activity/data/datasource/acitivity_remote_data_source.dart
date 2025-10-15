import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:town_pulse2/core/utils/api_services.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';

class AcitivityRemoteDataSource {
  final Api _api = Api.instance;
  final Dio _dio = Dio();
  final String _token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4ZDAyMzUzN2ZjN2IxNjFmMGYzOTlmZCIsImlhdCI6MTc2MDUyMDk4MywiZXhwIjoxNzY4Mjk2OTgzfQ.bZLf37qkRCcghLuTylqnNB6HiYcC9LD9KVRdVJUD2JA";
  Future<List<Activity>> getAllActivity() async {
    try {
      final Response response = await _dio.get(
        'https://townpulse-backend-fehi.onrender.com/api/v1.0.0/activity',
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
          },
        ),
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
