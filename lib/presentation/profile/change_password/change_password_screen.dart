import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/button.dart';
import 'package:taga_cuyo/core/common_widgets/pass_textfield.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
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
        title: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.07),
          child: const Text("Create New Password"),
        ),
        toolbarHeight: 70,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Form(
            // Wrap the content in a Form widget for validation
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.25, // Dynamically adjusted
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
                ),
                const SizedBox(height: 20),
                const Text(
                  "Create a strong and secure password to protect your account, including a mix of letters, numbers, and special characters for better security.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                PasswordTextField(
                    controller: _oldpassword,
                    labelText: 'Current Password',
                    hintText: 'Enter your current password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your current password';
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                PasswordTextField(
                    controller: _npassword,
                    labelText: 'New Password',
                    hintText: 'Enter your new password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter your new password';
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                PasswordTextField(
                    controller: _cnpassword,
                    labelText: 'Confirm New Password',
                    hintText: 'Please confirm your password',
                    obscureText: true,
                    validator: (value) {
                      if (value != value) {
                        return 'Passwords do not match';
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                CustomButton(
                  onTab: () {},
                  text: "Update Password",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
