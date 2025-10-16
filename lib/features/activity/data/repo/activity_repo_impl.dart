import 'package:town_pulse2/features/activity/data/datasource/acitivity_remote_data_source.dart';
import 'package:town_pulse2/features/activity/data/model/activity_model.dart';
import 'package:town_pulse2/features/activity/data/repo/activity_repo.dart';

class ActivityRepoImpl implements ActivityRepo {
  final AcitivityRemoteDataSource remoteDataSource;
  ActivityRepoImpl(this.remoteDataSource);
  @override
  Future<List<Activity>> getAllActivity(String? token, String? category) async {
    return await remoteDataSource.getAllActivity(token, category);
  }
}
