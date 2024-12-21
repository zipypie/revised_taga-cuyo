import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/icons.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import 'package:taga_cuyo/presentation/profile/setting_menu.dart';
import 'package:taga_cuyo/presentation/profile/progress_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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

  Widget _userProfile(BuildContext context) {
    return Container(
      width: ScreenUtils.getScreenWidth(context),
      height: ScreenUtils.getScreenHeight(context, subtract: 130) / 6,
      decoration: BoxDecoration(
        color: AppColors.primaryBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.person, size: 50),
                ),
                const SizedBox(width: 20),
                Text('Juan Dela Cruz', style: TextStyles.h1b),
              ],
            ),
            const SettingsMenu(),
          ],
        ),
      ),
    );
  }

  Widget _userProgress(BuildContext context) {
    final List<Map<String, dynamic>> progressItems = [
      {
        'title': 'Lesson',
        'value': '0',
        'color': CustomColors.p1c,
        'icon': AppIcon.progress1
      },
      {
        'title': 'Category',
        'value': '3',
        'color': CustomColors.p2c,
        'icon': AppIcon.progress2
      },
      {
        'title': 'Minutes',
        'value': '5',
        'color': CustomColors.p3c,
        'icon': AppIcon.progress3
      },
      {
        'title': 'Days',
        'value': '5',
        'color': CustomColors.p4c,
        'icon': AppIcon.progress4
      },
      {
        'title': 'Longest Streak',
        'value': '5',
        'color': CustomColors.p5c,
        'icon': AppIcon.progress6
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Progress', style: TextStyles.h2b),
          const SizedBox(height: 15),
          Column(
            children: progressItems
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ProgressCard(
                      imagePath: item['icon'] as String,
                      title: item['title'] as String,
                      value: item['value'] as String,
                      color: item['color'] as Color,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
