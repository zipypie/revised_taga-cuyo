// app_routes.dart
import 'package:flutter/material.dart';
import 'package:taga_cuyo/presentation/category/category_screen.dart';
import 'package:taga_cuyo/presentation/home/home_screen.dart';
import 'package:taga_cuyo/presentation/lesson/lesson_screen.dart';
import 'package:taga_cuyo/presentation/profile/profile_screen.dart';
import 'package:taga_cuyo/presentation/translator/translator_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String translator = '/translator';
  static const String lesson = '/lesson';
  static const String category = '/category';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case translator:
        return MaterialPageRoute(builder: (_) => const TranslatorScreen());
      case lesson:
        return MaterialPageRoute(builder: (_) => const LessonScreen());
      case category:
        return MaterialPageRoute(builder: (_) => const CategoryScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const HomeScreen()); // Fallback
    }
  }
}
