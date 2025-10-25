import 'package:dio/dio.dart';
import 'package:town_pulse2/core/helper/CachHepler.dart';
import 'package:town_pulse2/features/activity/data/datasource/acitivity_remote_data_source.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/activity/data/repo/activity_repo.dart';

class ActivityRepoImpl implements ActivityRepo {
  final AcitivityRemoteDataSource remoteDataSource;
  ActivityRepoImpl(this.remoteDataSource);

  Future<List<Activity>> getAllActivity(String? token, String? category) async {
    return await remoteDataSource.getAllActivity(token, category);
  }

  @override
  Future<Activity> createActivity({
    required String token,
    required Map<String, dynamic> activityData,
  }) {
    return remoteDataSource.createActivity(
      token: token,
      activityData: activityData,
    );
  }

  @override
  Future<List<Activity>> getMyActivities(String token) async {
    try {
      final response = await remoteDataSource.getMyActivities(token);
      final rawData = response.data['data'];

      final currentUserId = CacheHelper.getData(key: 'user_id');
      final String? userIdString = currentUserId is String
          ? currentUserId
          : null;
      if (rawData == null) return [];

      List<dynamic> dataList;

      if (rawData is Map<String, dynamic> &&
          rawData.containsKey('activities')) {
        dataList = rawData['activities'];
      } else if (rawData is List) {
        dataList = rawData;
      } else {
        dataList = [];
      }

      final activities = dataList.map((e) => Activity.fromJson(e)).toList();

      if (userIdString != null) {
        return activities.where((a) => a.creator?.id == userIdString).toList();
      }

      return [];
    } on DioException catch (e) {
      throw Exception('فشل في الاتصال بالسيرفر: ${e.message}');
    } catch (e) {
      throw Exception('خطأ غير متوقع: $e');
    }
  }

  @override
  Future<void> deleteActivity(String id, String token) async {
    try {
      await remoteDataSource.deleteActivity(id, token);
    } on DioException catch (e) {
      throw Exception(
        'فشل في حذف النشاط: ${e.response?.data['message'] ?? e.message}',
      );
    } catch (e) {
      throw Exception('حدث خطأ أثناء الحذف: $e');
    }
  }

  @override
  Future<void> updateActivity(
    String id,
    Map<String, dynamic> activityData,
    String token,
  ) async {
    try {
      await remoteDataSource.updateActivity(id, activityData, token);
    } on DioException catch (e) {
      throw Exception(
        'فشل في تعديل النشاط: ${e.response?.data['message'] ?? e.message}',
      );
    } catch (e) {
      throw Exception('حدث خطأ أثناء التعديل: $e');
    }
  }

  @override
  Future<List<Activity>> getNearbyActivities({
    required double latitude,
    required double longitude,
  }) async {
    return await remoteDataSource.getNearByActivities(
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<List<Activity>> searchActivities(String query) async {
    try {
      final response = await remoteDataSource.searchActivities(query);
      final rawData = response.data['data'];

      if (rawData == null || rawData is! List) return [];

      final activities = rawData.map((e) => Activity.fromJson(e)).toList();
      return activities;
    } on DioException catch (e) {
      final message =
          e.message ??
          'فشل الاتصال بالخادم. الرجاء التحقق من الإنترنت وحالة الخادم.';
      throw Exception('فشل في البحث عن الأنشطة: $message');
    } catch (e) {
      throw Exception('خطأ غير متوقع أثناء البحث: $e');
    }
  }
}
