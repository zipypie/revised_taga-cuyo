import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/firestore_user_repository.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/models/my_user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseUserRepository _userRepository;
  final ImagePicker _picker;

  ProfileCubit(this._userRepository)
      : _picker = ImagePicker(),
        super(ProfileInitial());

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

  // Updated method to upload profile picture and update user's profile
  Future<void> uploadProfilePicture(String userId, File imageFile) async {
    try {
      emit(ProfileUploading());
      // Use the uploadPicture method from FirebaseUserRepository
      String downloadURL =
          await _userRepository.uploadPicture(imageFile.path, userId);
      emit(ProfileUploaded(downloadURL)); // Emit with the download URL
    } catch (e) {
      emit(ProfileError('Failed to upload profile picture: $e'));
    }
  }

  Future<File?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      return image != null ? File(image.path) : null;
    } catch (e) {
      emit(ProfileError('Failed to pick image: $e'));
      return null;
    }
  }
}
