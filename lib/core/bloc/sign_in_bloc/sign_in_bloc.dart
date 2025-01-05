import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:taga_cuyo/core/common_widgets/popup%20displays/snackbar.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository;

  SignInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        // Attempt sign in
        await _userRepository.signIn(event.email, event.password);

        // Check if email is verified
        bool isVerified = await _userRepository.isEmailVerified();
        log("Is email verified? $isVerified");

        if (isVerified) {
          emit(SignInSuccess());
        } else {
          emit(SignInEmailNotVerified());
        }
      } catch (e) {
        if (e is FirebaseAuthException) {
          String message = '';
          if (e.code == 'wrong-password') {
            message = 'Incorrect password.';
            emit(SignInFailure(message: message));
          } else if (e.code == 'user-not-found') {
            message = 'No user found for that email.';
            emit(SignInFailure(message: message));
          } else {
            message = 'Authentication error: ${e.message}';
            emit(SignInFailure(message: message));
          }

          // Show the snackbar using the context passed from the event
          showSnackBar(event.context, message);
        } else {
          log('Unexpected error: $e');
          emit(SignInFailure(message: 'Sign-in failed: $e'));
        }
      }
    });

    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
      emit(SignInInitial());
    });
  }
}
