import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/entities/my_user_progress_entity.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/models/my_user_progress.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/user_progress_repo.dart';
import 'package:taga_cuyo/core/repositories/user_repository/user_repository.dart';

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
}
