part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInRequired extends SignInEvent {
  final String email;
  final String password;
  final BuildContext context; // Added context

  const SignInRequired(
      this.email, this.password, this.context); // Constructor includes context

  @override
  List<Object> get props => [email, password, context];
}

class SignOutRequired extends SignInEvent {}
