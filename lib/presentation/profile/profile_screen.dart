import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/icons.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import 'package:taga_cuyo/presentation/profile/progress_card.dart';
import 'package:taga_cuyo/presentation/profile/setting_menu.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _userProfile(context),
          _userProgress(context),
        ],
      ),
    );
  }
}

//header part of the profile
// ProfileScreen.dart

Widget _userProfile(BuildContext context) {
  return Container(
    width: ScreenUtils.getScreenWidth(context),
    height: ScreenUtils.getScreenHeight(context, subtract: 130) / 6,
    decoration: BoxDecoration(
      color: AppColors.primaryBackground,
      border: const Border(
        bottom: BorderSide(
          color: Colors.black,
          width: 0.1, // Bottom border thickness
        ),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25), // Shadow color with opacity
          offset: const Offset(0, 2), // Horizontal and vertical shadow offset
          blurRadius: 4.0, // How blurry the shadow should be
          spreadRadius: 0.0, // How much the shadow should spread
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 20),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.primary, width: 5)),
              child: Icon(
                Icons.person,
                size: 50,
                color: CustomColors.userAvatar,
              ),
            ),
            SizedBox(width: 20),
            Text(
              'Juan Dela Cruz',
              style: TextStyles.h1b,
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(right: 20),
          child: SettingsMenu(), // Reusable SettingsMenu widget
        ),
      ],
    ),
  );
}

//User progress
Widget _userProgress(BuildContext context) {
  final width = ScreenUtils.getScreenWidth(context);
  return SizedBox(
    width: width,
    child: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress',
            style: TextStyles.h2b,
          ),
          SizedBox(height: 15),
          Column(
            children: [
              ProgressCard(
                imagePath: AppIcon.progress1,
                title: 'Lesson',
                value: '0',
                color: CustomColors.p1c, // Using the new accent color (p4c)
              ),
              SizedBox(height: 10),
              ProgressCard(
                imagePath: AppIcon.progress2,
                title: 'Category',
                value: '3',
                color: CustomColors.p2c, // Using the primary color (p2c)
              ),
              SizedBox(height: 10),
              ProgressCard(
                imagePath: AppIcon.progress3,
                title: 'Minutes',
                value: '5',
                color: CustomColors.p3c, // Using white (p3c)
              ),
              SizedBox(height: 10),
              ProgressCard(
                imagePath: AppIcon.progress4,
                title: 'Days',
                value: '5',
                color: CustomColors.p4c, // Using white again (p3c)
              ),
              SizedBox(height: 10),
              ProgressCard(
                imagePath: AppIcon.progress6,
                title: 'Longest Streak',
                value: '5',
                color: CustomColors.p5c, // Using white (p3c)
              ),
            ],
          )
        ],
      ),
    ),
  );
}
