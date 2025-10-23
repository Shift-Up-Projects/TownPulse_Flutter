import 'package:town_pulse2/features/attedence/data/datasource/attendance_remote_data_source.dart';
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
}
