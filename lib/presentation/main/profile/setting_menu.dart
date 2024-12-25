import 'package:flutter/material.dart';
import 'package:taga_cuyo/app/routes/routes.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/icons.dart';
import 'package:taga_cuyo/core/utils/logger.dart';
import 'package:taga_cuyo/presentation/main/profile/logout/logout_screen.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = {
      'Update Profile': Icons.person,
      'Change Password': Icons.lock,
      'Submit Ticket': Icons.airplane_ticket,
      'Feedback': Icons.feedback,
      'Terms and Conditions': Icons.description,
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
      'Update Profile': AppRoutes.updateProfile,
      'Change Password': AppRoutes.changePassword,
      'Submit Ticket': AppRoutes.submitTicket,
      'Feedback': AppRoutes.feedback,
      'Terms and Conditions': AppRoutes.termsAndCondition,
    };

    if (value == 'Logout') {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const LogoutScreen(), // Use your custom LogoutScreen
      );
    } else if (routes.containsKey(value)) {
      Navigator.pushNamed(
          context, routes[value]!); // Navigate using named routes
    } else {
      // Handle invalid or unrecognized options if needed
      logger.e('Invalid option selected: $value');
    }
  }
}
