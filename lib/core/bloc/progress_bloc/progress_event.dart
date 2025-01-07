part of 'progress_bloc.dart';

@immutable
abstract class ProgressEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SetUserProgressEvent extends ProgressEvent {
  final UserProgress userProgress;

  SetUserProgressEvent({required this.userProgress});

  @override
  List<Object> get props => [userProgress];
}

class GetUserProgressEvent extends ProgressEvent {}
