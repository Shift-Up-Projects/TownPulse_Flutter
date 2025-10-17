import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/features/activity/data/repo/activity_repo.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepo activityRepo;
  String? token;
  String? currentCategory;
  ActivityCubit(this.activityRepo, this.token) : super(ActivityIntial());

  Future<void> fetchAllActivity({String? category}) async {
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
      await fetchAllActivity(category: currentCategory);
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }

  void fetchMyActiviy() async {
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
    }
  }
}
