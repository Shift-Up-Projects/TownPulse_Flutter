import 'package:town_pulse2/features/attedence/data/datasource/attendance_remote_data_source.dart';
import 'package:town_pulse2/features/attedence/data/model/attendance_record_model.dart';
import 'package:town_pulse2/features/attedence/data/repo/attedance_repo.dart';

class AttendanceRepoImpl implements AttendanceRepo {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepoImpl(this.remoteDataSource);

  @override
  Future<void> markAttendance({
    required String userId,
    required String activityId,
    String status = "present",
  }) async {
    await remoteDataSource.markAttendance(
      userId: userId,
      activityId: activityId,
      status: status,
    );
  }

  @override
  Future<List<AttendanceRecord>> getMyAttendance(String token) async {
    final response = await remoteDataSource.getMyAttendance(token);

    final rawData = response.data['data'];

    if (rawData == null) return [];

    final attendanceList = rawData['attendance'];

    if (attendanceList == null || attendanceList is! List) return [];

    return (attendanceList)
        .map((json) => AttendanceRecord.fromJson(json))
        .toList();
  }

  @override
  Future<void> deleteAttendance(String attendanceId, String token) async {
    await remoteDataSource.deleteAttendance(attendanceId, token);
  }

  @override
  Future<Map<String, dynamic>> getAttendanceByActivity(
    String activityId,
    String token,
  ) async {
    final response = await remoteDataSource.getAttendanceByActivity(
      activityId,
      token,
    );
    final rawData = response.data['data'];

    if (rawData == null || rawData is! Map<String, dynamic>) {
      throw Exception('Invalid data received for activity attendees');
    }

    return rawData;
  }

  @override
  Future<void> updateAttendanceStatus(
    String attendanceId,
    String newStatus,
    String token,
  ) async {
    await remoteDataSource.updateAttendanceStatus(
      attendanceId,
      newStatus,
      token,
    );
  }
}
