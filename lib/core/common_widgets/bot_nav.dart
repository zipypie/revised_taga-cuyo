import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/screens/category/category.dart';
import 'package:taga_cuyo/screens/home/home.dart';
import 'package:taga_cuyo/screens/lesson/lesson.dart';
import 'package:taga_cuyo/screens/profile/profile.dart';
import 'package:taga_cuyo/screens/translator/translator.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
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
        toolbarHeight: 75,
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
