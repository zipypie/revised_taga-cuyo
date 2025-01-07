import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/user_progress_repo.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/models/my_user_progress.dart';

part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final UserProgressRepository _userProgressRepository;

  ProgressBloc({required UserProgressRepository userProgressRepository})
      : _userProgressRepository = userProgressRepository,
        super(ProgressInitial()) {
    // Handle saving user progress
    on<SetUserProgressEvent>((event, emit) async {
      try {
        emit(ProgressLoading());
        await _userProgressRepository.setUserProgressData(event.userProgress);
        emit(ProgressSuccess(
            userProgress:
                event.userProgress)); // Success state with user progress
      } catch (e) {
        emit(ProgressFailure(message: e.toString()));
      }
    });

    // Handle fetching user progress
    on<GetUserProgressEvent>((event, emit) async {
      try {
        emit(ProgressLoading());
        final userProgress =
            await _userProgressRepository.getUserProgressData();
        emit(ProgressSuccess(
            userProgress:
                userProgress)); // Success state with fetched user progress
      } catch (e) {
        emit(ProgressFailure(message: e.toString()));
      }
    });
  }
}
