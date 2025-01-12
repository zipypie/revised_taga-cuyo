import 'dart:developer'; // Import this for logging
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/models/feedback_model.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/user_repo.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final UserRepository userRepository;

  FeedbackCubit({required UserRepository myUserRepository})
      : userRepository = myUserRepository,
        super(FeedbackInitial());

  Future<void> submitFeedback(FeedbackModel feedback) async {
    emit(FeedbackLoading());
    try {
      final currentUserId = userRepository.getCurrentUserId();
      if (currentUserId == null) {
        emit(FeedbackFailure(error: 'No user is currently logged in.'));
        return;
      }

      // Fixed the syntax error here: "==" changed to "="
      final currentUser = await userRepository.getMyUser(currentUserId);

      // Assuming you have a method like this to save feedback
      await userRepository.addFeedbackToFirestore(feedback, currentUser);

      emit(FeedbackSuccess());
    } catch (e) {
      log("Failed to submit feedback: $e");
      emit(FeedbackFailure(error: e.toString()));
    }
  }
}
