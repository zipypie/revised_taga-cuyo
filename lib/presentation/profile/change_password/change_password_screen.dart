import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/button.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/icons.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Password"),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.secondaryBackground,
                borderRadius: BorderRadius.circular(100)),
            child: Image.asset(
              AppIcon.lock,
              width: 50,
              height: 50,
            ),
          ),
          CustomButton(onTab: () {}, text: "Update Password")
        ],
      ),
    );
  }
}
