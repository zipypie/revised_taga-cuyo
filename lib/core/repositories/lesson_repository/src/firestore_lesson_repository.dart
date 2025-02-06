import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/entities/lesson_entity/lesson_entity.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/lesson_repo.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/models/lesson_model/lesson_model.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/models/lesson_quiz_model/lesson_quiz_model.dart';

class FirebaseLessonRepository implements LessonRepository {
  final lessonsCollection = FirebaseFirestore.instance.collection('lessons');

  @override
  Future<List<LessonModel>> getLesson() async {
    try {
      final QuerySnapshot snapshot =
          await lessonsCollection.orderBy('lesson_id').get();

      final lessonList = snapshot.docs.map((doc) {
        final lessonEntity = LessonEntity.fromSnapshot(doc);
        return LessonModel.fromEntity(
            lessonEntity); // Make sure this is LessonModel
      }).toList();

      return lessonList;
    } catch (e) {
      log('Error fetching lessons: $e');
      throw Exception('Failed to load lessons');
    }
  }

  @override
  Future<List<LessonQuizModel>> getLessonQuiz() async {
    try {
      // Fetch the quizzes sub-collection for the specific lessonId
      final lessonDocRef = lessonsCollection.doc();
      final lessonQuizzesCollection = lessonDocRef.collection('words');

      final QuerySnapshot snapshot = await lessonQuizzesCollection.get();

      final quizList = snapshot.docs.map((doc) {
        final quizData = doc.data() as Map<String, dynamic>;
        return LessonQuizModel.fromJson(
            quizData); // Convert each document to LessonQuizModel
      }).toList();

      return quizList;
    } catch (e) {
      log('Error fetching lesson quizzes: $e');
      throw Exception('Failed to load lesson quizzes');
    }
  }

  @override
  Future<int> getLessonQuizCount(String id) async {
    try {
      final lessonDocRef = lessonsCollection.doc(id);
      final lessonQuizzesCollection = lessonDocRef.collection('words');

      final QuerySnapshot snapshot = await lessonQuizzesCollection.get();

      log('Lesson ID: , Quiz Count: ${snapshot.docs.length}'); // Debugging

      return snapshot.docs.length;
    } catch (e) {
      log('Error fetching lesson quizzes count: $e');
      throw Exception('Failed to load lesson quizzes count');
    }
  }
}
