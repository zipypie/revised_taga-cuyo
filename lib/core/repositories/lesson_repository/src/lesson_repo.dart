import 'package:taga_cuyo/core/repositories/lesson_repository/src/entities/lesson_entity.dart';

abstract class LessonRepository {
  Future<List<LessonEntity>> getLessonName(); // Return a list of lessons
  Future<List<Map<String, dynamic>>> getLessonQuiz(
      String lessonId); // Return quiz data for a specific lesson
}
