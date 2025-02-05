import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/entities/lesson_entity/lesson_entity.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/lesson_repo.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/models/lesson_model/lesson_model.dart';

class FirebaseLessonRepository implements LessonRepository {
  final lessonsCollection = FirebaseFirestore.instance.collection('lessons');

  // Constructor without the UserRepository dependency
  FirebaseLessonRepository();

  @override
  Future<List<LessonModel>> getLesson() async {
    try {
      // Fetch the lessons and order them by lesson_id
      final QuerySnapshot snapshot = await lessonsCollection
          .orderBy('lesson_id') // Sorting by lesson_id
          .get();

      // Map the snapshot data into a list of LessonModel
      final lessonList = snapshot.docs.map((doc) {
        // Convert the document snapshot to LessonEntity
        final lessonEntity = LessonEntity.fromSnapshot(doc);
        // Convert LessonEntity to LessonModel
        return LessonModel.fromEntity(lessonEntity);
      }).toList();

      // Return the list of LessonModel
      return lessonList;
    } catch (e) {
      log('Error fetching lesson names: $e');
      // Handle the error or throw to inform the caller
      throw Exception('Failed to load lessons');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getLessonQuiz(String lessonId) async {
    try {
      // Fetch the lesson quiz data based on the lessonId
      final quizSnapshot = await lessonsCollection
          .doc(lessonId)
          .collection(
              'words') // Assuming the quiz questions are in the 'words' subcollection
          .get();

      // Map the snapshot data into a list of quiz questions
      final quizList = quizSnapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      // Return the list of quiz questions
      return quizList;
    } catch (e) {
      log('Error fetching quiz for lesson $lessonId: $e');
      // Handle the error or throw to inform the caller
      throw Exception('Failed to load quiz');
    }
  }
}
