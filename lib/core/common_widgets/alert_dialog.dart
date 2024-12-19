import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

Future<void> showCustomAlertDialog(
  BuildContext context,
  String title,
  String content, {
  String buttonText = 'OK', // Default value for the button text
  Color? buttonColor, // Optional button color, defaults to the primary color
  Color? textColor, // Optional text color, defaults to white
  TextStyle? titleStyle, // Optional title style
  TextStyle? contentStyle, // Optional content style
}) {
  // Set default values if no value is passed for buttonColor and textColor
  buttonColor ??= AppColors.primary; // Default button color
  textColor ??= Colors.white; // Default text color

  // Default styles if not provided
  final defaultTitleStyle = titleStyle ??
      TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        fontFamily: AppFonts.fcb,
      );

  final defaultContentStyle = contentStyle ??
      TextStyle(
        fontSize: 21,
        fontFamily: AppFonts.fcr,
      );

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        elevation: 10, // Shadow effect for the dialog
        child: Container(
          padding: const EdgeInsets.all(20), // Padding inside the dialog
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground, // Dialog background color
            borderRadius: BorderRadius.circular(
                12), // Border radius matching the dialog shape
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Dialog size adjusted to content
            children: [
              // Title Text
              Text(
                title,
                style: defaultTitleStyle,
                textAlign: TextAlign.center, // Center title
              ),
              const SizedBox(height: 10),

              // Content Text
              Text(
                content,
                style: defaultContentStyle,
                textAlign: TextAlign.center, // Center content
              ),
              const SizedBox(height: 20),

              // Action Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: textColor, // Text color of the button
                  backgroundColor:
                      buttonColor, // Background color of the button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        25), // Rounded corners for the button
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 30), // Padding of the button
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  buttonText, // Button text
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily:
                        AppFonts.fcb, // Set the font family for the button text
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
