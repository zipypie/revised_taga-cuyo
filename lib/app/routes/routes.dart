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
  static const String cp = '/change_password';
  static const String st = '/submit_ticket';
  static const String f = '/feedback';
  static const String l = '/logout';
  static const String up = '/update_profile';
  static const String so = '/settings';
  static const String main = '/main_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(builder: (_) => MainAppScreen());
      case up:
        return MaterialPageRoute(builder: (_) => UpdateProfileScreen());
      case cp:
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case f:
        return MaterialPageRoute(builder: (_) => FeedbackScreen());
      case st:
        return MaterialPageRoute(builder: (_) => SubmitTicketScreen());
      case l:
        return MaterialPageRoute(builder: (_) => LogoutScreen());
      case so:
        return MaterialPageRoute(builder: (_) => SettingsMenu());
      default:
        return MaterialPageRoute(builder: (_) => MainAppScreen()); // Fallback
    }
  }
}
