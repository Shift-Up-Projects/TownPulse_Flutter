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
}
