import 'package:flutter/material.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/icons.dart';

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
          case 'Change Password':
            Navigator.pushNamed(context, AppRoutes.cp);
            break;
          case 'Submit Ticket':
            Navigator.pushNamed(context, AppRoutes.st);
            break;
          case 'Feedback':
            Navigator.pushNamed(context, AppRoutes.f);
            break;
          case 'Logout':
            Navigator.pushNamed(context, AppRoutes.l);
            break;
          case 'Update Profile':
            Navigator.pushNamed(context, AppRoutes.up);
            break;
          default:
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
      ],
    );
  }
}
