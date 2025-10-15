import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:town_pulse2/features/activity/data/repo/activity_repo.dart';
import 'package:town_pulse2/features/activity/presentation/cubit/activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final ActivityRepo activityRepo;
  ActivityCubit(this.activityRepo) : super(ActivityIntial());

  Future<void> fetchAllActivity() async {
    emit(ActivityLoading());
    try {
      final activities = await activityRepo.getAllActivity();
      emit(ActivityLoaded(activities));
    } catch (e) {
      emit(ActivityError(e.toString()));
    }
  }
}
