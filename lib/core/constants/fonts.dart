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
  static const TextStyle heading6 = TextStyle(
    fontFamily: AppFonts.lilitaOne,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.titleColor,
  );

  static const TextStyle heading1 = TextStyle(
    fontFamily: AppFonts.fcb,
    fontSize: 24,
    color: AppColors.titleColor,
  );

  static const TextStyle heading4 = TextStyle(
    fontFamily: AppFonts.fcb,
    fontSize: 21,
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
