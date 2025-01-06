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

  const SignInRequired(
    this.email,
    this.password,
  ); // Removed context here

  @override
  List<Object> get props => [email, password];
}

class SignOutRequired extends SignInEvent {}
