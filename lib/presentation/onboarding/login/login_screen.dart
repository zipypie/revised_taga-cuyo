import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/common_widgets/textfields/textfield.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/images.dart';
import 'package:taga_cuyo/core/bloc/sign_in_bloc/sign_in_bloc.dart';

import 'email_verification/email_verification.dart'; // Import your dialog

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _isDialogVisible = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: SafeArea(
        child: BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInProcess) {
              if (!_isDialogVisible) {
                _showLoadingDialog(context);
                _isDialogVisible = true;
              }
            } else {
              if (_isDialogVisible) {
                Navigator.pop(context); // Dismiss the loading dialog
                _isDialogVisible = false;
              }
            }

            if (state is SignInSuccess) {
              Navigator.pushNamed(context, AppRoutes.mainScreen);
            } else if (state is SignInFailure) {
              _showErrorSnackBar(context, state.message);
            } else if (state is SignInEmailNotVerified) {
              // Show the EmailVerificationDialog when email is not verified
              _showEmailVerificationDialog(context);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TopSection(height: height),
                _FormSection(
                  height: height,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String? message) {
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void _showEmailVerificationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const EmailVerificationDialog(); // Show your custom email verification dialog
      },
    );
  }
}

class _TopSection extends StatelessWidget {
  final double height;

  const _TopSection({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackground,
      child: Column(
        children: [
          SizedBox(height: 25),
          SizedBox(
              width: double.infinity,
              height: height * 0.28,
              child: LogoImage.logo(fit: BoxFit.contain)),
          Padding(
            padding: const EdgeInsets.all(30),
            child: const Text(
                'Welcome to Taga-Cuyo: Tagalog-Cuyonon Translation and Learning Application',
                textAlign: TextAlign.center,
                style: TextStyles.knt18),
          ),
        ],
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  final double height;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _FormSection({
    required this.height,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.025), // Adjustable space here
          CustomTextField(
            controller: emailController,
            hintText: "Enter your email",
            labelText: "E-mail",
            backgroundColor: AppColors.primaryBackground,
            prefixIcon: Icon(Icons.email),
          ),
          CustomTextField(
            controller: passwordController,
            hintText: "Enter your password",
            labelText: "Password",
            prefixIcon: Icon(Icons.lock),
            isPassword: true,
            backgroundColor: AppColors.primaryBackground,
          ),
          _ForgetPasswordLink(),
          SizedBox(height: height * 0.025), // Adjustable space here

          /// Login Button
          CustomButton(
            onTab: () {
              // Trigger the login process via Bloc
              BlocProvider.of<SignInBloc>(context).add(
                SignInRequired(
                  emailController.text,
                  passwordController.text,
                  context, // Pass the context to the event
                ),
              );
            },
            text: "Login",
          ),
          _SignUpOption(),
        ],
      ),
    );
  }
}

class _ForgetPasswordLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.forgotPassword);
        },
        child: Text(
          'Forgot password?',
          style: TextStyle(
            letterSpacing: 1,
            fontFamily: AppFonts.kanitLight,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0089EA),
          ),
        ),
      ),
    );
  }
}

class _SignUpOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, AppRoutes.signUpScreen);
      },
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account? Choose',
              style: TextStyles.knt16,
            ),
            TextSpan(
              text: ' Signup.',
              style: TextStyles.knt18b,
            ),
          ],
        ),
      ),
    );
  }
}
