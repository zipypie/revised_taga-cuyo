import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../repositories/user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({required UserRepository myUserRepository})
      : userRepository = myUserRepository,
        super(const AuthenticationState.unknown()) {
    _userSubscription = userRepository.user.listen((authUser) {
      add(AuthenticationUserChanged(authUser));
    });

    // Listen for changes in authentication status
    on<AuthenticationUserChanged>((event, emit) async {
      if (event.user != null) {
        if (event.user!.emailVerified) {
          // Save user to local storage if email is verified
          MyUser user = MyUser(
            uid: event.user!.uid,
            email: event.user!.email ?? '',
            firstName: '', // Fetch these fields if you have them
            lastName: '',
            age: '',
            hasCompletedSurvey:
                event.user!.emailVerified, // Update based on your logic
          );
          await userRepository.saveUserLocally(user);

          // Emit authenticated state
          emit(AuthenticationState.authenticated(event.user!));
        } else {
          // Emit email not verified state
          emit(AuthenticationState.emailNotVerified(event.user!));
        }
      } else {
        // No user logged in, emit unauthenticated state
        emit(const AuthenticationState.unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
