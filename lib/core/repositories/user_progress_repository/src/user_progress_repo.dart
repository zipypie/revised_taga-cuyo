import 'package:taga_cuyo/core/repositories/user_progress_repository/src/models/my_user_progress.dart';

import '../../category_repository.dart/categories_repository.dart';
import '../../category_repository.dart/src/models/subcategories_model.dart';
import 'models/category_quiz_completion.dart';

abstract class UserProgressRepository {
  Future<void> setUserProgressData(UserProgress userProgress);

  Future<UserProgress> getUserProgressData();

  Future<void> saveQuizCompletionData(
    String userId,
    CategoryModel category,
    SubcategoryModel subcategory,
    int score,
    int minutes,
    int seconds,
  );

  Future<List<CategoryQuizCompletion>> getQuizCompletionData(String userId);

  Future<void> updateUserOnlineDates(String userId);

  Future<void> updateUserProgressStatistics(String userId);
}
