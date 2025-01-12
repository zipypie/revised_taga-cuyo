import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/user_repository/src/models/submit_ticket_model.dart';
import '../../repositories/user_repository/src/user_repo.dart';

part 'submit_ticket_state.dart';

class SubmitTicketCubit extends Cubit<SubmitTicketState> {
  final UserRepository userRepository;

  SubmitTicketCubit({required UserRepository myUserRepository})
      : userRepository = myUserRepository,
        super(SubmitTicketInitial());

  // Submit the ticket and handle response
  Future<void> submitTicket(SubmitTicketModel ticket) async {
    emit(SubmitTicketLoading());
    try {
      final currentUserId = userRepository.getCurrentUserId();
      if (currentUserId == null) {
        emit(SubmitTicketFailure(error: "No user is currently logged in."));
        return;
      }

      // Add ticket to Firestore and wait for the result
      final currentUser = await userRepository.getMyUser(currentUserId);
      await userRepository.addTicketToFirestore(ticket, currentUser);

      // Emit success after the ticket is successfully uploaded
      emit(SubmitTicketSuccess());
    } catch (e) {
      log("Failed to submit ticket: $e");
      emit(SubmitTicketFailure(error: e.toString()));
    }
  }
}
