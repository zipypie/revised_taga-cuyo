import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/popup%20displays/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';

Future<void> showEmailVerificationDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Email Verification Required',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Your email is not verified. Please check your inbox and verify your email address.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomButton(
                  onTab: () {
                    Navigator.of(dialogContext).pop(); // Close the dialog

                    try {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null && !user.emailVerified) {
                        user.sendEmailVerification();
                        showSnackBar(
                          context, // Use the context passed to the function
                          'Verification email sent',
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                      } else {
                        showSnackBar(
                          context, // Use the context passed to the function
                          'Email is already verified',
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                        );
                      }
                    } catch (e) {
                      showSnackBar(
                        context, // Use the context passed to the function
                        'Failed to send verification email',
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    }
                  },
                  text: 'Send Verification Link')
            ],
          ),
        ),
      );
    },
  );
}
