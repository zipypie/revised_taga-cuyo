import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/icons.dart';
import 'package:taga_cuyo/presentation/profile/change_password/change_password_screen.dart';
import 'package:taga_cuyo/presentation/profile/feedback/feedback_screen.dart';
import 'package:taga_cuyo/presentation/profile/logout/logout_screen.dart';
import 'package:taga_cuyo/presentation/profile/submit_ticket/submit_ticket_screen.dart';
import 'package:taga_cuyo/presentation/profile/update_profile/update_profile_screen.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = {
      'Update Profile': Icons.person,
      'Change Password': Icons.lock,
      'Submit Ticket': Icons.airplane_ticket,
      'Feedback': Icons.feedback,
      'Logout': Icons.logout,
    };

    return PopupMenuButton<String>(
      icon: Image.asset(AppIcon.setting, width: 35, height: 35),
      color: AppColors.secondaryBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      offset: const Offset(0, 50),
      onSelected: (value) => handleSelection(context, value),
      itemBuilder: (_) => menuItems.entries
          .map(
            (entry) => PopupMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  Icon(entry.value, color: AppColors.titleColor),
                  const SizedBox(width: 10),
                  Text(entry.key),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  void handleSelection(BuildContext context, String value) {
    final routes = {
      'Update Profile': const UpdateProfileScreen(),
      'Change Password': const ChangePasswordScreen(),
      'Submit Ticket': const SubmitTicketScreen(),
      'Feedback': const FeedbackScreen(),
      'Logout': LogoutScreen(),
    };

    if (value == 'Logout') {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => LogoutScreen(),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => routes[value]!),
      );
    }
  }
}
