import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/button.dart';
import 'package:taga_cuyo/core/common_widgets/snackbar.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

class EmailVerificationDialog extends StatefulWidget {
  const EmailVerificationDialog({super.key});

  @override
  State<EmailVerificationDialog> createState() =>
      _EmailVerificationDialogState();
}

///TODO: Implement the Email Verification  and Sending link to the email

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
              onTab: () {
                Navigator.of(context).pop(); // Close the dialog first
                // showSnackBar(
                //   context,
                //   'Verification email sent',
                //   backgroundColor: AppColors.accentColor,
                //   textColor: AppColors.primaryBackground,
                //   behavior: SnackBarBehavior.floating,
                //   borderRadius: BorderRadius.circular(15),
                //   duration: const Duration(seconds: 5),
                // ); // Custom duration);

                showSnackBar(
                  context,
                  'Failed to send verification email',
                  backgroundColor: AppColors.wrong,
                  textColor: AppColors.primaryBackground,
                  behavior: SnackBarBehavior.floating,
                  borderRadius: BorderRadius.circular(15),
                  duration: const Duration(seconds: 5),
                ); // Custom duration);
              },
              text: 'Send Verification Email',
            ),
          ],
        ),
      ),
    );
  }
}
