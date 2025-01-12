part of 'feedback_cubit.dart';

sealed class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

final class FeedbackInitial extends FeedbackState {}

final class FeedbackLoading extends FeedbackState {}

final class FeedbackSuccess extends FeedbackState {}

final class FeedbackFailure extends FeedbackState {
  final String error;

  const FeedbackFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class FeedbackUploading extends FeedbackState {}
