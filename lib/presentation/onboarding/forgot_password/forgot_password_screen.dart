import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/button.dart';
import 'package:taga_cuyo/core/common_widgets/textfield.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/icons.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password', style: TextStyles.h1b),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.secondaryBackground),
              child: Image.asset(AppIcon.lock,
                  width: ScreenUtils.getScreenWidth(context) * 0.4),
            ),
            SizedBox(height: ScreenUtils.getScreenWidth(context) * 0.05),
            Text(
              'Enter the email address associated with your account, and we will send you a link to reset your password. Please ensure that the email you provide is valid and accessible.',
              style: TextStyles.knt18,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ScreenUtils.getScreenWidth(context) * 0.05),
            CustomTextField(
                controller: email,
                prefixIcon: Icon(Icons.email),
                labelText: 'Email',
                hintText: 'Enter your email'),
            CustomButton(onTab: () {}, text: 'Send Reset Link'),
          ],
        ),
      ),
    );
  }
}
