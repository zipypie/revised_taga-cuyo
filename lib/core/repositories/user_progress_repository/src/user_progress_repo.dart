import 'package:taga_cuyo/core/repositories/user_progress_repository/src/models/my_user_progress.dart';

abstract class UserProgressRepository {
  Future<void> setUserProgressData(UserProgress userProgress);

  Future<UserProgress> getUserProgressData();
}
