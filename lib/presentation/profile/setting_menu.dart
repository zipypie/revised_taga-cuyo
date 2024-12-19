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
    return PopupMenuButton<String>(
      icon: Image.asset(
        AppIcon.setting, // Your settings icon asset
        width: 35,
        height: 35,
      ),
      color: AppColors.secondaryBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      offset: const Offset(0, 50), // Adjust the position as needed
      onSelected: (String value) {
        switch (value) {
          case 'Update Profile':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UpdateProfileScreen()),
            );
            break;
          case 'Change Password':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
            );
            break;
          case 'Submit Ticket':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SubmitTicketScreen()),
            );
            break;
          case 'Feedback':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FeedbackScreen()),
            );
            break;
          case 'Logout':
            showDialog<void>(
              context: context,
              barrierDismissible:
                  false, // Prevent closing the dialog by tapping outside
              builder: (BuildContext context) {
                return LogoutScreen();
              },
            );
            break;

          default:
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Update Profile',
          child: Row(
            children: [
              Icon(Icons.person, color: AppColors.titleColor),
              const SizedBox(width: 10),
              const Text('Update Profile'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Change Password',
          child: Row(
            children: [
              Icon(Icons.lock, color: AppColors.titleColor),
              const SizedBox(width: 10),
              const Text('Change Password'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Submit Ticket',
          child: Row(
            children: [
              Icon(Icons.airplane_ticket, color: AppColors.titleColor),
              const SizedBox(width: 10),
              const Text('Submit Ticket'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Feedback',
          child: Row(
            children: [
              Icon(Icons.feedback, color: AppColors.titleColor),
              const SizedBox(width: 10),
              const Text('Feedback'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Logout',
          child: Row(
            children: [
              Icon(Icons.logout, color: AppColors.titleColor),
              const SizedBox(width: 10),
              const Text('Logout'),
            ],
          ),
        ),
      ],
    );
  }
}
