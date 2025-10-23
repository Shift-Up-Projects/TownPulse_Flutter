import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/features/attedence/data/repo/attedance_repo.dart';

part 'attedence_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final AttendanceRepo repo;

  AttendanceCubit(this.repo) : super(AttendanceInitial());

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
}
