import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/user_repo.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final UserRepository _userRepository;

  ForgotPasswordCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ForgotPasswordInitial());

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      emit(const ForgotPasswordFailure(message: 'Email cannot be empty.'));
      return;
    }

    emit(ForgotPasswordLoading());

    try {
      await _userRepository.resetPassword(email);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(ForgotPasswordFailure(message: 'Failed to send reset link: $e'));
    }
  }
}
