import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/entities/category_quiz_completion_entity.dart';
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
    final userProgressRef =
        FirebaseFirestore.instance.collection('user_progress').doc(userId);

    try {
      // Fetch the user's progress document
      final userDocSnapshot = await userProgressRef.get();

      // Fetch the completed category quizzes subcollection to count the completed categories
      final completedQuizzesRef =
          userProgressRef.collection('completed_category_quizzes');
      final completedQuizzesSnapshot = await completedQuizzesRef.get();
      final completedCategoriesCount = completedQuizzesSnapshot.docs.length;

      if (userDocSnapshot.exists) {
        final userData = userDocSnapshot.data()!;

        // Get the current total minutes and seconds
        final existingMinutes = userData['minutes'] ?? 0;
        final existingSeconds = userData['seconds'] ?? 0;

        // Add the new minutes and seconds to the existing values
        final totalSeconds = existingSeconds + seconds;
        final extraMinutes =
            totalSeconds ~/ 60; // Convert seconds to minutes if > 60
        final remainingSeconds =
            totalSeconds % 60; // Get remaining seconds after conversion

        final updatedMinutes = existingMinutes + minutes + extraMinutes;
        final updatedSeconds = remainingSeconds;

        // Update the user's progress with the new total minutes, seconds, and categories count
        await userProgressRef.update({
          'minutes': updatedMinutes,
          'seconds': updatedSeconds, // Store remaining seconds after conversion
          'categories':
              completedCategoriesCount, // Set categories based on the count of completed quizzes
        });

        log('User progress updated with new total minutes, seconds, and correct categories count.');
      } else {
        // If the user document doesn't exist, create it with initial values
        final totalSeconds = seconds;
        final extraMinutes =
            totalSeconds ~/ 60; // Convert seconds to minutes if > 60
        final remainingSeconds =
            totalSeconds % 60; // Get remaining seconds after conversion

        await userProgressRef.set({
          'minutes': minutes + extraMinutes,
          'seconds': remainingSeconds, // Store remaining seconds
          'categories':
              completedCategoriesCount, // Set categories to 0 initially
          'lessons': 0,
          'days': 0,
          'longestStreak': 0,
        });

        log('New user progress document created with initial values.');
      }

      // Now save the quiz completion data for the specific category/subcategory
      final quizCompletion = CategoryQuizCompletion(
        categoryName: category.getCategoryName,
        subcategoryName: subcategory.subCategoryName,
        score: score,
        minutes: minutes,
        seconds: seconds,
      );

      final quizCompletionEntity = quizCompletion.toEntity();
      final completionData = quizCompletionEntity.toMap();

      // Use Firestore's auto-generated document ID
      await completedQuizzesRef.add(completionData);

      log('Quiz completion data added or updated.');
    } catch (e) {
      log('Error saving quiz completion data: $e');
    }
  }

  @override
  Future<List<CategoryQuizCompletion>> getQuizCompletionData(
      String userId) async {
    final userProgressRef = FirebaseFirestore.instance
        .collection('user_progress')
        .doc(userId)
        .collection('completed_category_quizzes');

    final querySnapshot = await userProgressRef.get();

    return querySnapshot.docs
        .map((doc) => CategoryQuizCompletion.fromEntity(
              CategoryQuizCompletionEntity.fromMap(doc.data()),
            ))
        .toList();
  }
}
