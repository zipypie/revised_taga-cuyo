part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final MyUser user;

  ProfileLoaded(this.user);
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class ProfileUploading
    extends ProfileState {} // Add this state to track image upload

class ProfileUploaded extends ProfileState {
  final String imageUrl;

  ProfileUploaded(this.imageUrl);
}
