part of 'change_password_cubit.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {}

final class ChangePasswordFailure extends ChangePasswordState {
  final String errorMessage;

  const ChangePasswordFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
