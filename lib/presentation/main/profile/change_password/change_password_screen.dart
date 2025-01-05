import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/common_widgets/textfields/textfield.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/icons.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldpassword = TextEditingController();
  final TextEditingController _npassword = TextEditingController();
  final TextEditingController _cnpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenUtils.getScreenWidth(context);
    final screenHeight = ScreenUtils.getScreenHeight(context, subtract: 70);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create New Password",
          style: TextStyles.h1b,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildPasswordImage(screenWidth, screenHeight),
                const SizedBox(height: 20),
                _buildDescriptionText(),
                _buildPasswordField(_oldpassword, 'Current Password',
                    'Enter your current password', false),
                _buildPasswordField(_npassword, 'New Password',
                    'Enter your new password', false),
                _buildPasswordField(_cnpassword, 'Confirm New Password',
                    'Please confirm your password', true),
                CustomButton(
                  onTab: () {
                    // Add password update logic here
                  },
                  text: "Update Password",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for password field generation
  Widget _buildPasswordField(TextEditingController controller, String labelText,
      String hintText, bool isConfirmPassword) {
    return CustomTextField(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      isPassword: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $labelText';
        }
        if (isConfirmPassword && value != _npassword.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  // Helper method for the password image
  Widget _buildPasswordImage(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth,
      height: screenHeight * 0.25,
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Image.asset(
          AppIcon.lock,
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  // Helper method for the description text
  Widget _buildDescriptionText() {
    return const Text(
      "Create a strong and secure password to protect your account, including a mix of letters, numbers, and special characters for better security.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
    );
  }
}
