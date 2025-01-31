import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTab;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  const CustomButton(
      {super.key,
      required this.onTab,
      required this.text,
      this.backgroundColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.primary,
              borderRadius: BorderRadius.circular(15)),
          child: Text(
            text,
            style: TextStyles.buttonDark
                .copyWith(color: textColor ?? AppColors.titleColor),
          ),
        ),
      ),
    );
  }
}
