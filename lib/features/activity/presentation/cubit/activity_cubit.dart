import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/core/widgets/showToast.dart';
import 'package:town_pulse2/features/activity/data/repo/activity_repo.dart';
import 'package:town_pulse2/features/activity/get_near_by_gio.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepo activityRepo;
  String? token;
  String? currentCategory;
  ActivityCubit(this.activityRepo, this.token) : super(ActivityIntial());

  Future<void> getAllActivity({String? category}) async {
    emit(ActivityLoading());
    try {
      currentCategory = category;
      final activities = await activityRepo.getAllActivity(token, category);
      emit(ActivityLoaded(activities));
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }

  Future<void> createActivity(Map<String, dynamic> activityData) async {
    emit(ActivityCreating());
    try {
      if (token == null) {
        emit(ActivityError("User not authenticated"));
        return;
      }
      final newActivity = await activityRepo.createActivity(
        token: token!,
        activityData: activityData,
      );
      emit(ActivityCreated(newActivity));
      // Optionally, refresh the activity list after creation
      await getAllActivity(category: currentCategory);
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }

  void getMyActiviy() async {
    emit(ActivityLoading());
    try {
      if (token == null) {
        emit(ActivityError("User not authenticated"));
        return;
      }
      final activities = await activityRepo.getMyActivities(token!);
      emit(ActivityLoaded(activities));
    } catch (e) {
      emit(ActivityError(e.toString()));
      log(e.toString());
    }
  }

  void deleteActivity(String id) async {
    emit(ActivityLoading());
    try {
      await activityRepo.deleteActivity(id, token!);
      emit(ActivityDeleted());
      getMyActiviy();
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }

  void updateActivity(String id, Map<String, dynamic> activityData) async {
    emit(ActivityLoading());
    try {
      await activityRepo.updateActivity(id, activityData, token!);
      emit(ActivityUpdated());
      getMyActiviy();
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }

  void fetchNearbyActivities(double lat, double lon, int maxDistance) async {
    emit(ActivityLoading());

    try {
      final activities = await activityRepo.getNearbyActivities(
        latitude: lat,
        longitude: lon,
        maxDistance: maxDistance,
      );
      emit(ActivityLoaded(activities));
    } catch (e) {
      emit(ActivityError('فشل في جلب الانشطة القريبة '));
    }
  }

  Future<void> searchActivities(String query) async {
    if (query.trim().isEmpty) {
      await getAllActivity(category: currentCategory);
      return;
    }

    emit(ActivityLoading());
    try {
      final activities = await activityRepo.searchActivities(query);
      emit(ActivityLoaded(activities));
    } catch (e) {
      emit(ActivityError('فشل في جلب نتائج البحث: ${e.toString()}'));
    }
  }
}

// void getNearbyActivities(BuildContext context) async {
//   try {
//     final pos = await determinePosition();
//     if (pos != null) {
//       context.read<ActivityCubit>().fetchNearbyActivities(
//         pos.latitude,
//         pos.longitude,

//       );
//     }
//   } catch (e) {
//     ShowToast(message: e.toString(), state: toastState.error);
//   }
// }
