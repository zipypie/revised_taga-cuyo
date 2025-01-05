import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Import

class EmailVerificationDialog extends StatefulWidget {
  const EmailVerificationDialog({super.key});

  @override
  State<EmailVerificationDialog> createState() =>
      _EmailVerificationDialogState();
}

class _EmailVerificationDialogState extends State<EmailVerificationDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Email Verification Required',
              style: TextStyles.h2b,
            ),
            const SizedBox(height: 20),
            const Text(
              'Your email is not verified. Please check your inbox and verify your email address.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTab: () async {
                Navigator.of(context).pop(); // Close the dialog first

                try {
                  // Send verification email
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null && !user.emailVerified) {
                    await user.sendEmailVerification();

                    // Use the correct context to show the snackbar
                    if (mounted) {
                      // Delay context usage in an async function
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          // Use ScaffoldMessenger to show snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Verification email sent'),
                              backgroundColor: AppColors.accentColor,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        }
                      });
                    }
                  } else {
                    if (mounted) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email is already verified'),
                              backgroundColor: AppColors.accentColor,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              duration: const Duration(seconds: 5),
                            ),
                          );
                        }
                      });
                    }
                  }
                } catch (e) {
                  if (mounted) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to send verification email'),
                            backgroundColor: AppColors.wrong,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      }
                    });
                  }
                }
              },
              text: 'Send Verification Email',
            ),
          ],
        ),
      ),
    );
  }
}
