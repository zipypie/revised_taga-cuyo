import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTab;
  final String text;
  const CustomButton({super.key, required this.onTab, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(25)),
          child: Text(
            text,
            style: TextStyles.buttonLight,
          ),
        ),
      ),
    );
  }
}
