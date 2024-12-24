import 'package:flutter/material.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/core/common_widgets/button.dart';
import 'package:taga_cuyo/core/common_widgets/drop_down.dart';
import 'package:taga_cuyo/core/common_widgets/terms%20and%20condition/terms_and_condition.dart';
import 'package:taga_cuyo/core/common_widgets/textfield.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/images.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';

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
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final height = ScreenUtils.getScreenHeight(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(LogoImage.logoPath, height: height * 0.15),
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
                labelText: 'Gender',
                value: selectedGender,
                items: ['Male', 'Female', 'Other', 'Prefer not to say'],
                hintText: 'Select your gender',
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) async {
                      if (value == true) {
                        // Show the Terms and Conditions dialog
                        bool? agreed = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return TermsAndCondition(
                              onShowRow: true, // Pass the flag to show the row
                            );
                          },
                        );

                        // If the user agrees, check the checkbox
                        if (agreed == true) {
                          setState(() {
                            isChecked = true;
                          });
                        } else {
                          // If the user cancels, keep the checkbox unchecked
                          setState(() {
                            isChecked = false;
                          });
                        }
                      } else {
                        // Allow unchecking directly
                        setState(() {
                          isChecked = false;
                        });
                      }
                    },
                  ),
                  Expanded(
                    child: Text(
                      "I agree to the terms and conditions.",
                      style: TextStyle(fontSize: 18, fontFamily: AppFonts.fcr),
                    ),
                  ),
                ],
              ),
              CustomButton(onTab: () {}, text: 'Sign Up'),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.loginScreen);
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyles.knt16,
                      ),
                      TextSpan(
                        text: 'Login',
                        style: TextStyles.knt18b,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
