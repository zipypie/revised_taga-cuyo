// app_routes.dart
import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/app_screen.dart';
import 'package:taga_cuyo/presentation/profile/change_password/change_password_screen.dart';
import 'package:taga_cuyo/presentation/profile/feedback/feedback_screen.dart';
import 'package:taga_cuyo/presentation/profile/logout/logout_screen.dart';
import 'package:taga_cuyo/presentation/profile/setting_menu.dart';
import 'package:taga_cuyo/presentation/profile/submit_ticket/submit_ticket_screen.dart';
import 'package:taga_cuyo/presentation/profile/update_profile/update_profile_screen.dart';

class AppRoutes {
  static const String cp = '/Change Password';
  static const String st = '/Submit Ticket';
  static const String f = '/Feedbac';
  static const String l = '/Logout';
  static const String up = '/Update Profile';
  static const String so = '/settings';
  static const String main = '/main_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => const MainAppScreen());
      case up:
        return MaterialPageRoute(builder: (_) => const UpdateProfileScreen());
      case cp:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      case f:
        return MaterialPageRoute(builder: (_) => const FeedbackScreen());
      case st:
        return MaterialPageRoute(builder: (_) => const SubmitTicketScreen());
      case l:
        return MaterialPageRoute(builder: (_) => const LogoutScreen());
      case so:
        return MaterialPageRoute(builder: (_) => const SettingsMenu());
      default:
        return MaterialPageRoute(
            builder: (_) => const MainAppScreen()); // Fallback
    }
  }
}
