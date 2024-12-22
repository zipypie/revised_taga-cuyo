import 'package:flutter/material.dart';
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
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.secondaryBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopSection(height),
              _buildFormSection(context, height),
            ],
          ),
        ),
      ),
    );
  }

  // Top section with logo and welcome message
  Widget _buildTopSection(double height) {
    return Container(
      color: AppColors.primaryBackground,
      child: Column(
        children: [
          SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            height: height * 0.28,
            child:
                LogoImage.logo, // Assuming this widget exists in your codebase
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: const Text(
              'Maligayang Pagdating sa Taga-Cuyo: Tagalog-Cuyonon isang Pagsasalin at Pag-aaral gamit ang Aplikasyon',
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 1,
                fontFamily: AppFonts.kanitLight,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Form section with text fields and buttons
  Widget _buildFormSection(BuildContext context, double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Use CustomTextField for email
          CustomTextField(
            controller: emailController,
            hintText: "",
            labelText: "E-mail", // Use the hint text as labelText
            backgroundColor: AppColors.primaryBackground,
            prefixIcon: Icon(Icons.email),
            isPassword: false, // Don't enable the password field behavior
            isEditable: true, // Field is editable
          ),
          const SizedBox(height: 10),
          _buildForgetPasswordLink(context),
          // Use PasswordTextField for password
          CustomTextField(
            prefixIcon: Icon(Icons.lock), // Lock icon for password field
            controller: passwordController,
            labelText: "Password", // Label for the password field
            hintText: "Enter your password", // Hint text for the password field
            isPassword:
                true, // Set to true to show password toggle (visibility)
            isEditable:
                true, // Set to true if you want the field to be editable
            backgroundColor:
                AppColors.primaryBackground, // Custom background color
          ),

          const SizedBox(height: 30),
          _buildSignInButton(),
          SizedBox(height: height / 20),
          _buildSignUpOption(context),
        ],
      ),
    );
  }

  // "Forgot password?" link
  Widget _buildForgetPasswordLink(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          // Navigate to ForgetPasswordScreen
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ForgetPasswordScreen(),
          //   ),
          // );
        },
        child: Text(
          'Nakalimutan ang password?',
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

  // Sign in button
  Widget _buildSignInButton() {
    return CustomButton(
      onTab: () {
        // Add sign-in logic here
      },
      text: "Mag-login",
    );
  }

  // Sign-up option text
  Widget _buildSignUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Wala pang account? Piliin ang',
          style: TextStyle(
            fontFamily: AppFonts.kanitLight,
            fontSize: 16,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigate to SignUpScreen
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => SignUpScreen(),
            //   ),
            // );
          },
          child: const Text(
            ' SignUp.',
            style: TextStyle(
              fontFamily: AppFonts.kanitLight,
              fontSize: 17,
              letterSpacing: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
