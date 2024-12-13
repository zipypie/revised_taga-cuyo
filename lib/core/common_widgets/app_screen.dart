import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/screens/category/category_screen.dart';
import 'package:taga_cuyo/screens/home/home_screen.dart';
import 'package:taga_cuyo/screens/lesson/lesson_screen.dart';
import 'package:taga_cuyo/screens/profile/profile_screen.dart';
import 'package:taga_cuyo/screens/translator/translator_screen.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  // List of screen widgets
  final List<Widget> _screens = [
    const HomeScreen(),
    const TranslatorScreen(),
    const LessonScreen(),
    const CategoryScreen(),
    const ProfileScreen(),
  ];

  final List<String> _title = [
    'Home',
    'Translator',
    'Lesson',
    'Category',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Text(
          _title[_currentIndex],
          style: TextStyles.heading1,
        ),
        backgroundColor: AppColors.primary,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 65.0,
        items: const [
          Icon(Icons.home, size: 33, color: AppColors.titleColor),
          Icon(Icons.translate, size: 33, color: AppColors.titleColor),
          Icon(Icons.book, size: 33, color: AppColors.titleColor),
          Icon(Icons.category, size: 33, color: AppColors.titleColor),
          Icon(Icons.person, size: 33, color: AppColors.titleColor),
        ],
        color: AppColors.primary,
        buttonBackgroundColor: AppColors.primary,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _screens[_currentIndex], // Show the current screen based on index
    );
  }
}