import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/user_repo.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final UserRepository _userRepository;
  ChangePasswordCubit(this._userRepository) : super(ChangePasswordInitial());

  Future<void> updatePassword(String newPassword) async {
    try {
      emit(ChangePasswordLoading());
      await _userRepository.updatePassword(newPassword);
      emit(ChangePasswordSuccess());
    } catch (e) {
      emit(ChangePasswordFailure(errorMessage: e.toString()));
    }
  }
}
