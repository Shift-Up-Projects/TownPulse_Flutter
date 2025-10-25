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

  Future<Response> getAttendanceByActivity(
    String activityId,
    String token,
  ) async {
    final url = 'attendance/activity/$activityId/attendance';
    return await Api.instance.get(url: url, token: token);
  }

  Future<void> updateAttendanceStatus(
    String attendanceId,
    String newStatus,
    String token,
  ) async {
    try {
      final url = 'attendance/$attendanceId'; // PATCH /attendance/:id
      final body = {'status': newStatus};

      // نستخدم Api.instance.put الذي يعمل كـ PATCH/PUT
      await Api.instance.put(url: url, body: body, token: token);
      log(
        '✅ Attendance status updated successfully for: $attendanceId to $newStatus',
      );
    } on DioException catch (e) {
      log('❌ Dio error in updateAttendanceStatus: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('❌ Unexpected error in updateAttendanceStatus: $e');
      throw Exception('Unexpected error: $e');
    }
  }
}
