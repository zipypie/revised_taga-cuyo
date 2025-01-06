import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../error/errors.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInLoading()); // Emit loading state

      try {
        // Check the credentials before attempting sign-in
        await checkCredentials(event.email, event.password);

        // Proceed with sign-in
        await _userRepository.signIn(event.email, event.password);

        bool isVerified = await _userRepository.isEmailVerified();
        if (isVerified) {
          emit(SignInSuccess());
        } else {
          emit(SignInEmailNotVerified());
        }
      } catch (e) {
        String errorMessage = 'An unknown error occurred during sign-in.';

        if (e is FirebaseAuthException) {
          final failure = SignInWithEmailAndPasswordFailure.fromCode(e.code);
          failure.logError(); // Log the error
          errorMessage = failure.message; // Get the error message from failure
        } else {
          errorMessage = 'Sign-in failed: $e';
        }

        emit(SignInFailure(message: errorMessage));
      }
    });

    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
      emit(SignInInitial());
    });
  }

  // This is the function you're adding
  Future<void> checkCredentials(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw FirebaseAuthException(
        code: 'invalid-credential',
        message: 'Email and password cannot be empty.',
      );
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      throw FirebaseAuthException(
        code: 'invalid-email',
        message: 'Email is not valid or badly formatted.',
      );
    }
  }
}
