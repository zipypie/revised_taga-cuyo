import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/popup%20displays/snackbar.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/common_widgets/textfields/textfield_editable.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/cubit/profile_cubit/profile_cubit.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/firestore_user_repository.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/models/my_user.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(FirebaseUserRepository())..loadUserProfile(),
      child: const _UpdateProfileView(),
    );
  }
}

class _UpdateProfileView extends StatefulWidget {
  const _UpdateProfileView();

  @override
  State<_UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<_UpdateProfileView> {
  final TextEditingController fnController = TextEditingController();
  final TextEditingController lnController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  MyUser? currentUser;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile', style: TextStyles.h1b),
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded) {
            currentUser = state.user;
            fnController.text = state.user.firstName;
            lnController.text = state.user.lastName;
            emailController.text = state.user.email;
            genderController.text = state.user.gender ?? '';
            ageController.text = state.user.age;
          } else if (state is ProfileUpdated) {
            showSnackBar(context, 'Profile updated successfully!');
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileLoaded || currentUser != null) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: AppColors.primary,
                        foregroundImage: currentUser?.profileImage != null
                            ? NetworkImage(currentUser!.profileImage!)
                            : null,
                        child: currentUser?.profileImage == null
                            ? const Icon(
                                Icons.person,
                                size: 50,
                                color: AppColors.primaryBackground,
                              )
                            : null,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtils.getScreenHeight(context) * 0.03,
                    ),
                    TextfieldWithEditIcon(
                      label: 'First Name',
                      controller: fnController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),
                    TextfieldWithEditIcon(
                      label: 'Last Name',
                      controller: lnController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),
                    TextfieldWithEditIcon(
                      label: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    TextfieldWithEditIcon(
                      label: 'Gender',
                      controller: genderController,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),
                    TextfieldWithEditIcon(
                      label: 'Age',
                      controller: ageController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: width * 0.8,
                      child: CustomButton(
                        onTab: () {
                          if (currentUser != null) {
                            final updatedUser = currentUser!.copyWith(
                              firstName: fnController.text,
                              lastName: lnController.text,
                              email: emailController.text,
                              gender: genderController.text,
                              age: ageController.text,
                            );
                            context
                                .read<ProfileCubit>()
                                .updateUserProfile(updatedUser);
                          }
                        },
                        text: 'Update Profile',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('No user data available.'));
        },
      ),
    );
  }

  @override
  void dispose() {
    fnController.dispose();
    lnController.dispose();
    emailController.dispose();
    genderController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
