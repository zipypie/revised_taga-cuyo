import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/core/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/animations/splash_animation.dart';
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

  bool isFormValid = false;
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void validateAndSubmit() {
    setState(() {
      _autovalidateMode =
          AutovalidateMode.always; // Trigger validation only on submit
    });

    // Manually trigger validation before submitting
    if (!_formKey.currentState!.validate()) {
      showSnackBar(
        context,
        'You must fill up all the fields.',
        backgroundColor: Colors.red,
      );
      return;
    }

    // Ensure the user has checked the terms and conditions
    if (!isChecked) {
      showSnackBar(
        context,
        'You must agree to the terms and conditions.',
        backgroundColor: Colors.red,
      );
      return;
    }

    final user = MyUser(
      uid: '',
      firstName: fnController.text,
      lastName: lnController.text,
      email: emailController.text,
      age: ageController.text,
      gender: selectedGender,
      hasCompletedSurvey: false,
      createdAt: DateTime.now(),
    );

    context.read<SignUpBloc>().add(SignUpRequired(user, pController.text));
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
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: Column(
                      children: [
                        Image.asset(LogoImage.logoPath, height: height * 0.15),
                        Text('Sign Up', style: TextStyles.h1b),
                        Text('Create an account to get started.',
                            style: TextStyles.knt18),
                        CustomTextField(
                          controller: fnController,
                          labelText: 'First Name',
                          hintText: 'Enter your first name',
                          validator: (value) =>
                              FieldValidators.validateName(value, 'First Name'),
                        ),
                        CustomTextField(
                          controller: lnController,
                          labelText: 'Last Name',
                          hintText: 'Enter your last name',
                          validator: (value) =>
                              FieldValidators.validateName(value, 'Last Name'),
                        ),
                        CustomTextField(
                          controller: emailController,
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          validator: (value) =>
                              FieldValidators.validateEmail(value),
                        ),
                        CustomTextField(
                          controller: pController,
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          isPassword: true,
                          validator: (value) =>
                              FieldValidators.validatePassword(value),
                        ),
                        CustomTextField(
                          controller: ageController,
                          labelText: 'Age',
                          hintText: 'Enter your age',
                          validator: (value) =>
                              FieldValidators.validateAge(value),
                        ),
                        DropDown(
                          labelText: 'Gender',
                          value: selectedGender,
                          items: [
                            'Male',
                            'Female',
                            'Other',
                            'Prefer not to say'
                          ],
                          validator: (value) =>
                              FieldValidators.validateGender(value),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedGender = newValue;
                            });
                          },
                          hintText: 'Please select here',
                        ),
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
                                        fontFamily: AppFonts.fcr))),
                          ],
                        ),
                        CustomButton(
                          onTab: () => validateAndSubmit(),
                          text: 'Sign Up',
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                              context, AppRoutes.loginScreen),
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyles.knt16),
                            TextSpan(text: 'Login', style: TextStyles.knt18b),
                          ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  if (state is SignUpProcess) {
                    return Center(child: SplashAnimation.loading());
                  }
                  return Container();
                },
              )
            ],
          );
        },
      ),
    );
  }
}
