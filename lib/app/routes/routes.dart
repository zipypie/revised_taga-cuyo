// app_routes.dart
import 'package:flutter/material.dart';
import 'package:taga_cuyo/screens/category/category.dart';
import 'package:taga_cuyo/screens/home/home.dart';
import 'package:taga_cuyo/screens/lesson/lesson.dart';
import 'package:taga_cuyo/screens/profile/profile.dart';
import 'package:taga_cuyo/screens/translator/translator.dart';

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
