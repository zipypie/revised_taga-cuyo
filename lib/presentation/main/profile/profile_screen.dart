import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/bloc/my_user_bloc/my_user_bloc.dart';
import 'package:taga_cuyo/core/bloc/my_user_bloc/my_user_state.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/icons.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import 'package:taga_cuyo/presentation/main/profile/setting_menu.dart';
import 'package:taga_cuyo/presentation/main/profile/progress_card.dart';

import '../../../core/bloc/progress_bloc/progress_bloc.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    context.read<MyUserBloc>().add(GetMyUser(myUserId: userId));
    context
        .read<ProgressBloc>()
        .add(GetUserProgressEvent()); // Dispatch event to get user progress
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
    return BlocBuilder<MyUserBloc, MyUserState>(
      builder: (context, state) {
        // Set up the static container design
        return Container(
          width: ScreenUtils.getScreenWidth(context),
          height: ScreenUtils.getScreenHeight(context, subtract: 130) / 6,
          decoration: BoxDecoration(
            color: AppColors.primaryBackground,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
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
                    // CircleAvatar with default icon, and changes when profile image is available
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: state.status == MyUserStatus.loading
                          ? null
                          : state.user?.profileImage?.isNotEmpty == true
                              ? NetworkImage(state.user!.profileImage!)
                              : null,
                      backgroundColor: AppColors.primary,
                      child: state.status == MyUserStatus.loading ||
                              state.user?.profileImage?.isEmpty == true ||
                              state.user?.profileImage == null
                          ? Icon(
                              Icons.person,
                              size: 35,
                              color: Colors.white, // Default icon color
                            )
                          : null,
                    ),
                    const SizedBox(width: 20),
                    // Name text with "Juan Dela Cruz" placeholder initially
                    SizedBox(
                      child: Text(
                        state.status == MyUserStatus.loading
                            ? 'Loading ...' // Default text while loading
                            : '${state.user?.firstName ?? ''} ${state.user?.lastName ?? ''}', // Update when data arrives
                        style: TextStyles.h1b,
                      ),
                    ),
                  ],
                ),
                const SettingsMenu(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _userProgress(BuildContext context) {
    return BlocBuilder<ProgressBloc, ProgressState>(
      builder: (context, state) {
        // Static design for progress, values change
        final progressItems = [
          {
            'title': 'Lesson',
            'value': state is ProgressSuccess
                ? state.userProgress.lessons.toString()
                : '0',
            'color': CustomColors.p1c,
            'icon': AppIcon.progress1
          },
          {
            'title': 'Category',
            'value': state is ProgressSuccess
                ? state.userProgress.categories.toString()
                : '0',
            'color': CustomColors.p2c,
            'icon': AppIcon.progress2
          },
          {
            'title': 'Minutes',
            'value': state is ProgressSuccess
                ? state.userProgress.minutes.toString()
                : '0',
            'color': CustomColors.p3c,
            'icon': AppIcon.progress3
          },
          {
            'title': 'Days',
            'value': state is ProgressSuccess
                ? state.userProgress.days.toString()
                : '0',
            'color': CustomColors.p4c,
            'icon': AppIcon.progress4
          },
          {
            'title': 'Longest Streak',
            'value': state is ProgressSuccess
                ? state.userProgress.longestStreak.toString()
                : '0',
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
                    .map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ProgressCard(
                            imagePath: item['icon'] as String,
                            title: item['title'] as String,
                            value: item['value'] as String,
                            color: item['color'] as Color,
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
