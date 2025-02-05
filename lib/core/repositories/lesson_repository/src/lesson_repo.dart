import 'package:taga_cuyo/core/repositories/lesson_repository/src/models/lesson_model/lesson_model.dart';

abstract class LessonRepository {
  Future<List<LessonModel>> getLesson(); // Return a list of lessons
  Future<List<Map<String, dynamic>>> getLessonQuiz(
      String lessonId); // Return quiz data for a specific lesson
}
