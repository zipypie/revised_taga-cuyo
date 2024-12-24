// app_routes.dart
import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/app_screen.dart';
import 'package:taga_cuyo/core/common_widgets/terms%20and%20condition/terms_and_condition.dart';
import 'package:taga_cuyo/presentation/main/profile/change_password/change_password_screen.dart';
import 'package:taga_cuyo/presentation/main/profile/feedback/feedback_screen.dart';
import 'package:taga_cuyo/presentation/main/profile/logout/logout_screen.dart';
import 'package:taga_cuyo/presentation/main/profile/setting_menu.dart';
import 'package:taga_cuyo/presentation/main/profile/submit_ticket/submit_ticket_screen.dart';
import 'package:taga_cuyo/presentation/main/profile/update_profile/update_profile_screen.dart';
import 'package:taga_cuyo/presentation/onboarding/forgot_password/forgot_password_screen.dart';
import 'package:taga_cuyo/presentation/onboarding/login/login_screen.dart';
import 'package:taga_cuyo/presentation/onboarding/signup/signup_screen.dart';

class AppRoutes {
  // Route constants
  static const String mainScreen = '/main_screen';
  static const String updateProfile = '/update_profile';
  static const String changePassword = '/change_password';
  static const String feedback = '/feedback';
  static const String submitTicket = '/submit_ticket';
  static const String logout = '/logout';
  static const String settingsMenu = '/settings';
  static const String forgotPassword = '/forgot_password';
  static const String loginScreen = '/login_screen';
  static const String signUpScreen = '/signup_screen';
  static const String termsAndCondition = '/terms_and_condition';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// Main App Screen
      case mainScreen:
        return MaterialPageRoute(
          builder: (_) => MainAppScreen(),
          settings: settings,
        );

      ///
      /// Onboarding Routes
      case forgotPassword:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen(),
          settings: settings,
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
      case signUpScreen:
        return MaterialPageRoute(
          builder: (_) => SignupScreen(),
          settings: settings,
        );
      case termsAndCondition:
        return MaterialPageRoute(
          builder: (_) => TermsAndCondition(),
          settings: settings,
        );

      ///
      ///Settings Menu Routes
      case settingsMenu:
        return MaterialPageRoute(
          builder: (_) => SettingsMenu(),
          settings: settings,
        );
      case updateProfile:
        return MaterialPageRoute(
          builder: (_) => UpdateProfileScreen(),
          settings: settings,
        );
      case changePassword:
        return MaterialPageRoute(
          builder: (_) => ChangePasswordScreen(),
          settings: settings,
        );
      case feedback:
        return MaterialPageRoute(
          builder: (_) => FeedbackScreen(),
          settings: settings,
        );
      case submitTicket:
        return MaterialPageRoute(
          builder: (_) => SubmitTicketScreen(),
          settings: settings,
        );
      case logout:
        return MaterialPageRoute(
          builder: (_) => LogoutScreen(),
          settings: settings,
        );

      ///
      ///Default Route
      default:
        return MaterialPageRoute(
          builder: (_) => MainAppScreen(),
          settings: settings,
        ); // Fallback route
    }
  }
}
