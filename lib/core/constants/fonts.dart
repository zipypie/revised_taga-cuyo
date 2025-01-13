import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';

class AppFonts {
  static const String lilitaOne = 'LilitaOne';
  static const String kanitLight = 'Kanit';
  static const String roboto = 'Roboto-Regular';
  static const String feb = 'FEB';
  static const String fer = 'FER';
  static const String fcb = 'FCB';
  static const String fcr = 'FCR';
}

class TextStyles {
  /// Title Text Styles
  static const TextStyle h1b = TextStyle(
    fontFamily: AppFonts.fcb,
    fontSize: 24,
    color: AppColors.titleColor,
  );

  /// Header Text Styles
  static const TextStyle h2b = TextStyle(
    fontFamily: AppFonts.fcb,
    fontSize: 21,
    color: AppColors.titleColor,
  );

  static const TextStyle h2g = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: AppColors.grey,
  );
  static const TextStyle h3r = TextStyle(
    fontFamily: AppFonts.fcr,
    fontSize: 18,
    letterSpacing: 2,
    color: Color.fromARGB(255, 44, 41, 41),
  );

  static const TextStyle knt18 = TextStyle(
    letterSpacing: 1,
    fontFamily: AppFonts.kanitLight,
    color: Color.fromARGB(255, 47, 47, 47),
    fontSize: 18,
  );

  static const TextStyle knt18b = TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.kanitLight,
    color: Color.fromARGB(255, 47, 47, 47),
    fontSize: 18,
  );

  static const TextStyle knt16 = TextStyle(
    fontFamily: AppFonts.kanitLight,
    color: Color.fromARGB(255, 47, 47, 47),
    fontSize: 16,
  );
  static const TextStyle h4n = TextStyle(
    fontSize: 15,
    color: Color.fromARGB(255, 44, 41, 41),
  );

  static const TextStyle h3b = TextStyle(
    fontFamily: AppFonts.fcb,
    fontSize: 18,
    color: AppColors.titleColor,
  );

  /// Button Text Styles
  static const TextStyle buttonLight = TextStyle(
    fontFamily: AppFonts.fcb,
    fontSize: 21,
    color: AppColors.primaryBackground,
  );

  static const TextStyle buttonDark = TextStyle(
    fontFamily: AppFonts.fcb,
    fontSize: 21,
    color: AppColors.titleColor,
  );

  /// Terms and Condition Text Styles
  static const TextStyle termsTitle = TextStyle(
    fontFamily: AppFonts.fcb,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle termsContent = TextStyle(
    fontSize: 15,
  );

  static const TextStyle termsSectionTitle = TextStyle(
    fontFamily: AppFonts.fcb,
    fontSize: 21,
    fontWeight: FontWeight.bold,
  );
}
