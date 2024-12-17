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
  //for small heading
  static const TextStyle h3bLilita = TextStyle(
    fontFamily: AppFonts.lilitaOne,
    fontSize: 18,
    color: AppColors.titleColor,
  );

  static const TextStyle h1b = TextStyle(
    fontFamily: AppFonts.fcb,
    fontSize: 24,
    color: AppColors.titleColor,
  );

  static const TextStyle h2b = TextStyle(
    fontFamily: AppFonts.fcb,
    fontSize: 21,
    color: AppColors.titleColor,
  );

  static const TextStyle h3r = TextStyle(
    fontFamily: AppFonts.fcr,
    fontSize: 18,
    letterSpacing: 2,
    color: Color.fromARGB(255, 44, 41, 41),
  );

  static const TextStyle h4n = TextStyle(
    fontSize: 14,
    color: Color.fromARGB(255, 44, 41, 41),
  );

  static const TextStyle h3b = TextStyle(
    fontFamily: AppFonts.fcb,
    fontSize: 18,
    color: Color.fromARGB(255, 71, 71, 71),
  );

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
}
