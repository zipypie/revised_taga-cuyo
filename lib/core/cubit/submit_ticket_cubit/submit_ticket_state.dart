part of 'submit_ticket_cubit.dart';

sealed class SubmitTicketState extends Equatable {
  const SubmitTicketState();

  @override
  List<Object> get props => [];
}

final class SubmitTicketInitial extends SubmitTicketState {}

final class SubmitTicketLoading extends SubmitTicketState {}

final class SubmitTicketSuccess extends SubmitTicketState {}

final class SubmitTicketFailure extends SubmitTicketState {
  final String error;

  const SubmitTicketFailure({required this.error});

  @override
  List<Object> get props => [error];
}

final class SubmitTicketUploading extends SubmitTicketState {}
