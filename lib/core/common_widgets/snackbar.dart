import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';

void showSnackBar(
  BuildContext context,
  String content, {
  Color? backgroundColor,
  Color? textColor,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
  BorderRadius? borderRadius,
  Duration duration = const Duration(seconds: 3),
  TextAlign textAlign = TextAlign.center, // Default text alignment
}) {
  final snackBar = SnackBar(
    behavior: behavior,
    shape: RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(15),
    ),
    content: Builder(
      builder: (BuildContext context) {
        return Text(
          content,
          style: TextStyle(
              color: textColor ?? AppColors.primaryBackground,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          textAlign: textAlign, // Apply textAlign directly to Text widget
        );
      },
    ),
    backgroundColor: backgroundColor ?? AppColors.primary,
    duration: duration,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
