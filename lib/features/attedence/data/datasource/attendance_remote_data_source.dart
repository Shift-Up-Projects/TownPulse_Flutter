import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:town_pulse2/core/utils/api_services.dart';

class AttendanceRemoteDataSource {
  Future<void> markAttendance({
    required String userId,
    required String activityId,
    String status = "present",
  }) async {
    try {
      final body = {
        "user_id": userId,
        "activity_id": activityId,
        "status": status,
      };

      log('➡️ Sending attendance: $body');

      final response = await Api.instance.post(url: 'attendance', body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('✅ Attendance marked successfully');
      } else {
        log('❌ Attendance failed: ${response.data}');
        throw Exception(response.data['message'] ?? 'فشل تسجيل الحضور');
      }
    } on DioException catch (e) {
      log('❌ Dio error in markAttendance: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('❌ Unexpected error in markAttendance: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Response> getMyAttendance(String token) async {
    return await Api.instance.get(
      url: 'attendance/my/attendance',
      token: token,
    );
  }

  Future<void> deleteAttendance(String attendanceId, String token) async {
    try {
      await Api.instance.delete(url: 'attendance/$attendanceId', token: token);
      log('✅ Attendance record deleted successfully: $attendanceId');
    } on DioException catch (e) {
      log('❌ Dio error in deleteAttendance: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('❌ Unexpected error in deleteAttendance: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}
