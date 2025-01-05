import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/core/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/popup%20displays/snackbar.dart';
import 'package:taga_cuyo/core/common_widgets/terms%20and%20condition/terms_and_condition.dart';
import 'package:taga_cuyo/core/models/field_validator.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/models/my_user.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/drop_down.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/images.dart';

import '../../../core/common_widgets/textfields/textfield.dart';

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

  final _formKey = GlobalKey<FormState>();

  // Validate form fields and submit
  void validateAndSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final user = MyUser(
        uid: '', // Initially empty, will be set by Firebase
        firstName: fnController.text,
        lastName: lnController.text,
        email: emailController.text,
        age: ageController.text,
        gender: selectedGender,
        hasCompletedSurvey: false, // Default to false
        createdAt: DateTime.now(), // Set current timestamp for account creation
      );

      // Trigger SignUp event
      context.read<SignUpBloc>().add(SignUpRequired(user, pController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = ScreenUtils.getScreenHeight(context);

    return Scaffold(
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            showSnackBar(
              context,
              'Sign-up successful! Redirecting to login.',
              backgroundColor: Colors.green,
              textColor: Colors.white,
            );
            Navigator.pushNamed(context, AppRoutes.loginScreen);
          } else if (state is SignUpFailure) {
            showSnackBar(
              context,
              'Sign-up failed. Please try again.',
              backgroundColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(LogoImage.logoPath, height: height * 0.15),
                        Text('Sign Up', style: TextStyles.h1b),
                        Text(
                          'Create an account to get started.',
                          style: TextStyles.knt18,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        // First Name
                        CustomTextField(
                          controller: fnController,
                          labelText: 'First Name',
                          hintText: 'Enter your first name',
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              FieldValidators.validateName(value, 'First Name'),
                        ),
                        // Last Name
                        CustomTextField(
                          controller: lnController,
                          labelText: 'Last Name',
                          hintText: 'Enter your last name',
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              FieldValidators.validateName(value, 'Last Name'),
                        ),
                        // Email
                        CustomTextField(
                          controller: emailController,
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) =>
                              FieldValidators.validateEmail(value),
                        ),
                        // Password
                        CustomTextField(
                          controller: pController,
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          isPassword: true,
                          validator: (value) =>
                              FieldValidators.validatePassword(value),
                        ),
                        // Age
                        CustomTextField(
                          controller: ageController,
                          labelText: 'Age',
                          hintText: 'Enter your age',
                          keyboardType: TextInputType.number,
                          validator: (value) =>
                              FieldValidators.validateAge(value),
                        ),
                        // Gender
                        DropDown(
                          labelText: 'Gender',
                          value: selectedGender,
                          items: [
                            'Male',
                            'Female',
                            'Other',
                            'Prefer not to say',
                          ],
                          hintText: 'Select your gender',
                          validator: (value) =>
                              FieldValidators.validateGender(value),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGender = newValue;
                            });
                          },
                        ),
                        // Terms and Conditions
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (bool? value) async {
                                if (value == true) {
                                  bool? agreed = await showDialog<bool>(
                                    context: context,
                                    builder: (context) =>
                                        TermsAndCondition(onShowRow: true),
                                  );
                                  setState(() => isChecked = agreed ?? false);
                                } else {
                                  setState(() => isChecked = false);
                                }
                              },
                            ),
                            Expanded(
                              child: Text(
                                "I agree to the terms and conditions.",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: AppFonts.fcr,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Loading or Sign-up Button
                        if (state is SignUpProcess)
                          const CircularProgressIndicator()
                        else
                          CustomButton(
                            onTab: () {
                              if (!isChecked) {
                                showSnackBar(
                                  context,
                                  'You must agree to the terms and conditions.',
                                  backgroundColor: Colors.red,
                                );
                                return;
                              }
                              validateAndSubmit();
                            },
                            text: 'Sign Up',
                          ),
                        // Login redirect
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
