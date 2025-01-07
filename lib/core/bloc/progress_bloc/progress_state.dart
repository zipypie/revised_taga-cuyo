part of 'progress_bloc.dart';

@immutable
abstract class ProgressState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {}

class ProgressSuccess extends ProgressState {
  final UserProgress userProgress;

  ProgressSuccess({required this.userProgress});

  @override
  List<Object?> get props => [userProgress];
}

class ProgressFailure extends ProgressState {
  final String message;

  ProgressFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
