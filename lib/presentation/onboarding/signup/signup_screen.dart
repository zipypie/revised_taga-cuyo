import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/button.dart';
import 'package:taga_cuyo/core/common_widgets/drop_down.dart';
import 'package:taga_cuyo/core/common_widgets/textfield.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/images.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController fnController = TextEditingController();
  final TextEditingController lnController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(LogoImage.logoPath, height: 200),
                Text(
                  'Sign Up',
                  style: TextStyles.h1b,
                ),
                Text('Create an account to get started.',
                    style: TextStyles.knt18),
              ],
            ),
            CustomTextField(
                controller: fnController,
                labelText: 'First Name',
                hintText: 'Enter your first name',
                keyboardType: TextInputType.text),
            CustomTextField(
                controller: lnController,
                labelText: 'Last Name',
                hintText: 'Enter your last name',
                keyboardType: TextInputType.text),
            CustomTextField(
              controller: emailController,
              labelText: 'Email',
              hintText: 'Enter your first name',
              keyboardType: TextInputType.text,
            ),
            CustomTextField(
                controller: pController,
                labelText: 'Password',
                hintText: 'Enter your password',
                isPassword: true),
            CustomTextField(
              controller: ageController,
              labelText: 'Age',
              hintText: 'Enter your age',
              keyboardType: TextInputType.number,
            ),
            DropDown(
              value: selectedGender,
              items: ['Male', 'Female', 'Other', 'Prefer not to say'],
              hintText: 'Select your gender',
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),
            CustomButton(onTab: () {}, text: 'Sign Up'),
          ],
        ),
      ),
    );
  }
}
