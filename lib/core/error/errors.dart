import 'dart:developer';

class SignInWithEmailAndPasswordFailure implements Exception {
  const SignInWithEmailAndPasswordFailure({
    this.message = 'An unknown exception occurred.',
    this.code,
  });

  factory SignInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-credential':
        return const SignInWithEmailAndPasswordFailure(
          message: 'Incorrect email or password. Please try again!',
          code: 'invalid-credential',
        );
      case 'too-many-requests':
        return const SignInWithEmailAndPasswordFailure(
          message: 'Too many sign-in attempts. Please try again later.',
          code: 'too-many-requests',
        );
      default:
        return const SignInWithEmailAndPasswordFailure();
    }
  }

  final String message;
  final String? code;

  @override
  String toString() {
    return 'SignInWithEmailAndPasswordFailure{message: $message, code: $code}';
  }

  void logError() {
    log('Error occurred during sign-in: $message (Code: $code)');
  }
}
