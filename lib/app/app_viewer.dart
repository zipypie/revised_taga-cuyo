import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/constants/images.dart';
import 'package:taga_cuyo/presentation/main/category/category_screen.dart';
import 'package:taga_cuyo/presentation/main/home/home_screen.dart';
import 'package:taga_cuyo/presentation/main/lesson/lesson_screen.dart';
import 'package:taga_cuyo/presentation/main/profile/profile_screen.dart';
import 'package:taga_cuyo/presentation/main/translator/translator_screen.dart';
import 'package:taga_cuyo/core/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:taga_cuyo/core/bloc/my_user_bloc/my_user_bloc.dart'; // Import MyUserBloc

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _currentIndex = 0;

  final List<String> _title = [
    'Home',
    'Translator',
    'Lesson',
    'Category',
    'Profile',
  ];

  // List of colors for selected and unselected icons
  final Color _selectedColor = AppColors.titleColor;
  final Color _unselectedColor = AppColors.titleColor;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        // If the user is authenticated, pass the user data
        if (state.status == AuthenticationStatus.authenticated) {
          final user = state.user; // Access authenticated user

          // Create a list of screens, passing userId to ProfileScreen
          final List<Widget> screens = [
            const HomeScreen(),
            const TranslatorScreen(),
            const LessonScreen(),
            const CategoryScreen(),
            BlocProvider(
              create: (context) => MyUserBloc(
                myUserRepository:
                    context.read<AuthenticationBloc>().userRepository,
              ),
              child: ProfileScreen(
                  userId: user!.uid), // Pass userId to ProfileScreen
            ),
          ];

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 65.0,
              title: Text(
                _title[_currentIndex], // Dynamic title based on selected screen
                style: TextStyles.h1b,
              ),
              backgroundColor: AppColors.primary,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    LogoImage.logoPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              index: _currentIndex,
              height: 65.0,
              items: [
                Icon(Icons.home,
                    size: 33,
                    color:
                        _currentIndex == 0 ? _selectedColor : _unselectedColor),
                Icon(Icons.translate,
                    size: 33,
                    color:
                        _currentIndex == 1 ? _selectedColor : _unselectedColor),
                Icon(Icons.book,
                    size: 33,
                    color:
                        _currentIndex == 2 ? _selectedColor : _unselectedColor),
                Icon(Icons.category,
                    size: 33,
                    color:
                        _currentIndex == 3 ? _selectedColor : _unselectedColor),
                Icon(Icons.person,
                    size: 33,
                    color:
                        _currentIndex == 4 ? _selectedColor : _unselectedColor),
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
            body: screens[_currentIndex],
          );
        } else {
          // If the user is not authenticated, show login screen or any other fallback
          return const Scaffold(
            body: Center(
              child: Text('User is not authenticated'),
            ),
          );
        }
      },
    );
  }
}
