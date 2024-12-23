import 'package:flutter/material.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/core/common_widgets/button.dart';
import 'package:taga_cuyo/core/common_widgets/textfield.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/images.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: SafeArea(
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
            child: LogoImage.logo,
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
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
          const SizedBox(height: 10),
          _ForgetPasswordLink(),
          const SizedBox(height: 20),
          CustomButton(onTab: () {}, text: "Login"),
          SizedBox(height: height / 20),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account? Choose',
          style: TextStyle(
            fontFamily: AppFonts.kanitLight,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.signUpScreen);
          },
          child: const Text(
            ' SignUp.',
            style: TextStyle(
              fontFamily: AppFonts.kanitLight,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}
