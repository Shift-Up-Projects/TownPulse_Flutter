part of 'attedence_cubit.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceSuccess extends AttendanceState {}

class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError(this.message);
}

class MyAttendanceLoading extends AttendanceState {}

class MyAttendanceLoaded extends AttendanceState {
  final List<AttendanceRecord> records;
  MyAttendanceLoaded(this.records);
}

class AttendanceDeleted extends AttendanceState {}

class ActivityAttendeesLoading extends AttendanceState {}

class ActivityAttendeesLoaded extends AttendanceState {
  final List<AttendanceRecord> attendees;
  final Map<String, dynamic> statistics;
  ActivityAttendeesLoaded(this.attendees, this.statistics);
}

class AttendanceUpdating extends AttendanceState {}

class AttendanceUpdatedSuccessfully extends AttendanceState {
  final String message;
  AttendanceUpdatedSuccessfully(this.message);
}
