import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

Future<Object?>? showCustomAlertDialog(
  GlobalKey<NavigatorState> navigatorKey, // Correct parameter type
  String title,
  String content, {
  String buttonText = 'OK',
  Color? buttonColor,
  Color? textColor,
  TextStyle? titleStyle,
  TextStyle? contentStyle,
}) {
  buttonColor ??= AppColors.primary;
  textColor ??= Colors.white;

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

  return navigatorKey.currentState?.push(
    MaterialPageRoute(
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: defaultTitleStyle, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text(content,
                    style: defaultContentStyle, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: textColor,
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 30),
                  ),
                  onPressed: () {
                    navigatorKey.currentState?.pop();
                  },
                  child: Text(buttonText,
                      style: TextStyle(fontSize: 18, fontFamily: AppFonts.fcb)),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
