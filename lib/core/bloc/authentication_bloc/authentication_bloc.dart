import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/user_repo.dart';

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

    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != null) {
        if (event.user!.emailVerified) {
          emit(AuthenticationState.authenticated(event.user!));
        } else {
          emit(AuthenticationState.emailNotVerified(
              event.user!)); // Emitting emailNotVerified state
        }
      } else {
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
