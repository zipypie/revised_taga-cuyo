import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

class ProgressCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String value;
  final Color color;

  const ProgressCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      height: height * 0.1,
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: color,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    imagePath,
                    width: 40, // Resize width
                    height: 40, // Resize height
                    fit: BoxFit
                        .contain, // Ensures the image is contained inside the bounds
                  ),
                ),
              ),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyles.h4n,
              ),
            ],
          ),
          Text(
            value,
            style: TextStyles.h3b,
          ),
        ],
      ),
    );
  }
}
