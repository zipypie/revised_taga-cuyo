import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/models/my_user.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/user_repo.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

// SignUpBloc
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());

      try {
        // Attempt to sign up the user
        MyUser user = await _userRepository.signUp(event.user, event.password);
        await _userRepository.setUserData(user);
        emit(SignUpSuccess());
      } catch (e) {
        // Handle FirebaseAuthException specifically
        if (e is FirebaseAuthException) {
          if (e.code == 'email-already-in-use') {
            emit(SignUpFailure(message: 'Email is already in use.'));
          } else {
            emit(SignUpFailure(message: 'An unknown error occurred.'));
          }
        } else {
          emit(SignUpFailure(message: 'An unknown error occurred.'));
        }
      }
    });
  }
}
