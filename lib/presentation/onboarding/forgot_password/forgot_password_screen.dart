import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/popup%20displays/snackbar.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/common_widgets/textfields/textfield.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/icons.dart';
import 'package:taga_cuyo/core/models/field_validator.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/user_repo.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import 'package:taga_cuyo/presentation/onboarding/forgot_password/cubit/forgot_password_cubit.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(
        userRepository: RepositoryProvider.of<UserRepository>(context),
      ),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password', style: TextStyles.h1b),
        centerTitle: true,
      ),
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordFailure) {
            showSnackBar(context, state.message);
          }
          if (state is ForgotPasswordSuccess) {
            showSnackBar(context, 'Password reset link sent',
                backgroundColor: AppColors.darkGreen,
                textColor: AppColors.primaryBackground);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.secondaryBackground,
                    ),
                    child: Image.asset(
                      AppIcon.lock,
                      width: ScreenUtils.getScreenWidth(context) * 0.4,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtils.getScreenWidth(context) * 0.05,
                  ),
                  Text(
                    'Enter the email address associated with your account, and we will send you a link to reset your password. Please ensure that the email you provide is valid and accessible.',
                    style: TextStyles.knt18,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: ScreenUtils.getScreenWidth(context) * 0.05,
                  ),
                  Form(
                    key: _formKey,
                    child: CustomTextField(
                      controller: emailController,
                      validator: (value) =>
                          FieldValidators.validateEmail(value),
                      prefixIcon: const Icon(Icons.email),
                      labelText: 'Email',
                      hintText: 'Enter your email',
                    ),
                  ),
                  const SizedBox(height: 16),
                  state is ForgotPasswordLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          onTab: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context
                                  .read<ForgotPasswordCubit>()
                                  .resetPassword(emailController.text.trim());
                            }
                          },
                          text: 'Send Reset Link',
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
