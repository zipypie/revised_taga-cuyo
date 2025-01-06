import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/common_widgets/textfields/textfield.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/images.dart';
import 'package:taga_cuyo/core/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:taga_cuyo/core/models/field_validator.dart';
import 'package:taga_cuyo/presentation/onboarding/login/email_verification/email_verification.dart';

import '../../../core/common_widgets/popup displays/alert_dialog.dart';

// Declare a scaffoldMessengerKey to manage Snackbar messages
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  bool _isDialogShown = false; // Add this flag

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: SafeArea(
        child: BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              Navigator.pushNamed(context, AppRoutes.mainScreen);
            } else if (state is SignInFailure) {
              _showErrorDialog(context, state.message);
            } else if (state is SignInEmailNotVerified && !_isDialogShown) {
              _isDialogShown = true;
              showEmailVerificationDialog(context).then((_) {
                _isDialogShown = false;
              });
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
                  formKey: _formKey,
                  autovalidateMode: _autovalidateMode,
                  onSubmit: validateAndSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateAndSubmit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    if (!_formKey.currentState!.validate()) {
      return;
    }

    BlocProvider.of<SignInBloc>(context).add(
      SignInRequired(
        emailController.text,
        passwordController.text,
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String? message) {
    if (message != null && message.isNotEmpty) {
      showCustomAlertDialog(
        context,
        'Login Failed',
        message,
      );
    }
  }
}

class _FormSection extends StatelessWidget {
  final double height;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  final VoidCallback onSubmit;

  const _FormSection({
    required this.height,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.autovalidateMode,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.025),
            CustomTextField(
              controller: emailController,
              hintText: "Enter your email",
              labelText: "E-mail",
              backgroundColor: AppColors.primaryBackground,
              prefixIcon: Icon(Icons.email),
              validator: (value) => FieldValidators.validateEmail(value),
            ),
            CustomTextField(
              controller: passwordController,
              hintText: "Enter your password",
              labelText: "Password",
              prefixIcon: Icon(Icons.lock),
              isPassword: true,
              backgroundColor: AppColors.primaryBackground,
              validator: (value) => FieldValidators.validatePassword(value),
            ),
            _ForgetPasswordLink(),
            SizedBox(height: height * 0.025),
            CustomButton(
              onTab: onSubmit,
              text: "Login",
            ),
            _SignUpOption(),
          ],
        ),
      ),
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
