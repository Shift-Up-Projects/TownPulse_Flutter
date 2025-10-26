import 'package:town_pulse2/features/attedence/data/model/attendance_record_model.dart';

abstract class AttendanceRepo {
  Future<void> markAttendance({
    required String userId,
    required String activityId,
    String status,
  });
  Future<List<AttendanceRecord>> getMyAttendance(String token);

  Future<void> deleteAttendance(String attendanceId, String token);
  Future<Map<String, dynamic>> getAttendanceByActivity(
    String activityId,
    String token,
  );
  Future<void> updateAttendanceStatus(
    String attendanceId,
    String newStatus,
    String token,
  );
}
