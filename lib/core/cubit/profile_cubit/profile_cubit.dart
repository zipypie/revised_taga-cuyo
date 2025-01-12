import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/firestore_user_repository.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/models/my_user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._userRepository) : super(ProfileInitial());

  final FirebaseUserRepository _userRepository;

  Future<void> loadUserProfile() async {
    try {
      emit(ProfileLoading());
      final userId = _userRepository.getCurrentUserId();
      if (userId == null) {
        emit(ProfileError('User not logged in.'));
        return;
      }
      final user = await _userRepository.getMyUser(userId);
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError('Failed to load profile: $e'));
    }
  }

  Future<void> updateUserProfile(MyUser updatedUser) async {
    try {
      emit(ProfileUpdating());
      await _userRepository.setUserData(updatedUser);
      emit(ProfileUpdated());
    } catch (e) {
      emit(ProfileError('Failed to update profile: $e'));
    }
  }
}
