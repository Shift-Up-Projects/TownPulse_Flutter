abstract class AttendanceRepo {
  Future<void> markAttendance({
    required String userId,
    required String activityId,
    String status,
  });
}
