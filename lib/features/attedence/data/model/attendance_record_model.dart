// lib/features/attedence/data/model/attendance_record_model.dart
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/auth/data/model/user_model.dart';

class AttendanceRecord {
  final String id;
  final User? user;
  final Activity? activity;
  final String status;
  final DateTime createdAt;

  AttendanceRecord({
    required this.id,
    this.user,
    this.activity,
    required this.status,
    required this.createdAt,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      id: json['_id'] as String,
      user: json['user_id'] != null && json['user_id'] is Map<String, dynamic>
          ? User.fromJson(json['user_id'])
          : null,
      activity:
          json['activity_id'] != null &&
              json['activity_id'] is Map<String, dynamic>
          ? Activity.fromJson(json['activity_id'])
          : null,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
