import 'package:taga_cuyo/core/repositories/lesson_repository/src/models/lesson_model/lesson_model.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/models/lesson_quiz_model/lesson_quiz_model.dart';

abstract class LessonRepository {
  Future<List<LessonModel>> getLesson();

  Future<List<LessonQuizModel>> getLessonQuiz();

  Future<int> getLessonQuizCount(String id);
}
