import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/features/attedence/data/model/attendance_record_model.dart';
import 'package:town_pulse2/features/attedence/data/repo/attedance_repo.dart';

part 'attedence_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceRepo repo;

  AttendanceCubit(this.repo) : super(AttendanceInitial());
  String? get token => CacheHelper.getData(key: 'token') as String?;
  Future<void> markAttendance({
    required String userId,
    required String activityId,
  }) async {
    emit(AttendanceLoading());
    try {
      await repo.markAttendance(userId: userId, activityId: activityId);
      emit(AttendanceSuccess());
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }

  Future<void> getMyAttendance() async {
    if (token == null) {
      emit(AttendanceError('User not authenticated'));
      return;
    }
    emit(MyAttendanceLoading());
    try {
      final records = await repo.getMyAttendance(token!);
      emit(MyAttendanceLoaded(records));
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }

  Future<void> deleteAttendance(String attendanceId) async {
    if (token == null) {
      emit(AttendanceError('User not authenticated'));
      return;
    }
    try {
      await repo.deleteAttendance(attendanceId, token!);
      emit(AttendanceDeleted());
      await getMyAttendance();
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }

  Future<void> fetchActivityAttendees(String activityId) async {
    if (token == null) {
      emit(AttendanceError('User not authenticated'));
      return;
    }
    emit(ActivityAttendeesLoading());
    try {
      final rawData = await repo.getAttendanceByActivity(activityId, token!);

      final attendanceList = rawData['attendance'] as List<dynamic>? ?? [];
      final statistics = rawData['statistics'] as Map<String, dynamic>? ?? {};

      final attendees = attendanceList
          .map((json) => AttendanceRecord.fromJson(json))
          .toList();

      emit(ActivityAttendeesLoaded(attendees, statistics));
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }

  Future<void> updateAttendanceStatus({
    required String attendanceId,
    required String newStatus,
    required String activityId,
  }) async {
    if (token == null) {
      emit(AttendanceError('User not authenticated'));
      return;
    }
    emit(AttendanceUpdating());
    try {
      await repo.updateAttendanceStatus(attendanceId, newStatus, token!);

      emit(
        AttendanceUpdatedSuccessfully('تم تحديث حالة الحضور إلى $newStatus'),
      );

      await fetchActivityAttendees(activityId);
    } catch (e) {
      emit(AttendanceError(e.toString()));
      await fetchActivityAttendees(activityId);
    }
  }
}
