import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/entities/my_user_progress_entity.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/models/my_user_progress.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/user_progress_repo.dart';
import 'package:taga_cuyo/core/repositories/user_repository/user_repository.dart';

import '../../category_repository.dart/categories_repository.dart';
import '../../category_repository.dart/src/models/subcategories_model.dart';
import 'models/category_quiz_completion.dart';

class FirebaseUserProgressRepository implements UserProgressRepository {
  final UserRepository _userRepository;
  final usersProgressCollection =
      FirebaseFirestore.instance.collection('user_progress');

  FirebaseUserProgressRepository({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<void> setUserProgressData(UserProgress userProgress) async {
    try {
      // Get the current user ID from UserRepository
      final userId = _userRepository.getCurrentUserId();
      if (userId == null) throw Exception("User not authenticated");

      // Save progress data using user ID
      await usersProgressCollection
          .doc(userId)
          .set(userProgress.toEntity().toMap());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // New method to get the user progress data
  @override
  Future<UserProgress> getUserProgressData() async {
    try {
      // Get the current user ID from UserRepository
      final userId = _userRepository.getCurrentUserId();
      if (userId == null) throw Exception("User not authenticated");

      // Fetch the document for user progress
      final doc = await usersProgressCollection.doc(userId).get();

      // Check if the document exists
      if (doc.exists) {
        // Convert Firestore document to UserProgress
        return UserProgress.fromEntity(UserProgressEntity.fromMap(doc.data()!));
      } else {
        throw Exception("User progress data not found");
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> saveQuizCompletionData(
    String userId,
    CategoryModel category,
    SubcategoryModel subcategory,
    int score,
    int minutes,
    int seconds,
  ) async {
    // Fetch existing quiz completion data from Firebase
    final userProgressRef = FirebaseFirestore.instance
        .collection('user_progress')
        .doc(userId)
        .collection('completed_quizzes');

    final querySnapshot = await userProgressRef
        .where('categoryName', isEqualTo: category.getCategoryName)
        .where('subcategoryName', isEqualTo: subcategory.subCategoryName)
        .get();

    // If there's existing data
    if (querySnapshot.docs.isNotEmpty) {
      final existingData = querySnapshot.docs.first.data();
      final existingScore = existingData['score'] as int;

      // Only update if the new score is higher
      if (score > existingScore) {
        // Create the CategoryQuizCompletion model with the new score and time
        final quizCompletion = CategoryQuizCompletion(
          categoryName: category.getCategoryName,
          subcategoryName: subcategory.subCategoryName,
          score: score,
          minutes: minutes,
          seconds: seconds,
        );

        // Convert to the CategoryQuizCompletionEntity
        final quizCompletionEntity = quizCompletion.toEntity();

        // Convert the entity to a map for Firestore
        final completionData = quizCompletionEntity.toMap();

        // Update the existing document with new score, minutes, and seconds
        await userProgressRef
            .doc(querySnapshot.docs.first.id)
            .update(completionData);
      }
    } else {
      // If no existing data, create a new document with the score, minutes, and seconds
      final quizCompletion = CategoryQuizCompletion(
        categoryName: category.getCategoryName,
        subcategoryName: subcategory.subCategoryName,
        score: score,
        minutes: minutes,
        seconds: seconds,
      );

      // Convert to the CategoryQuizCompletionEntity
      final quizCompletionEntity = quizCompletion.toEntity();

      // Convert the entity to a map for Firestore
      final completionData = quizCompletionEntity.toMap();

      // Save the new data (score + time) if there's no previous record
      await userProgressRef.add(completionData);
    }
  }
}
