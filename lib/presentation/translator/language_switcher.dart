import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/models/language_model.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';

class LanguageSwitcher extends StatefulWidget {
  final LanguagePair languagePair;
  final VoidCallback onLanguageSwap;

  const LanguageSwitcher({
    super.key,
    required this.languagePair,
    required this.onLanguageSwap,
  });

  @override
  LanguageSwitcherState createState() => LanguageSwitcherState();
}

class LanguageSwitcherState extends State<LanguageSwitcher> {
  // Method to swap languages
  void swapLanguages() {
    setState(() {
      widget.onLanguageSwap(); // Swap the languages in the parent widget
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: ScreenUtils.getScreenWidth(context),
        height: ScreenUtils.getScreenHeight(context) * 0.1,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Language 1 container with AnimatedSwitcher
              SizedBox(
                width: 150,
                child: AnimatedSwitcher(
                  duration: const Duration(
                      milliseconds: 500), // Set animation duration
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: animation.drive(
                        Tween<Offset>(begin: Offset(0, 0), end: Offset(1.5, 0)),
                      ),
                      child: child,
                    );
                  },
                  child: Container(
                    key: ValueKey<String>(widget.languagePair.language1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      widget.languagePair.language2,
                      style: const TextStyle(
                        color: AppColors.titleColor,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.fcr,
                      ),
                    ),
                  ),
                ),
              ),

              // Swap Button
              IconButton(
                onPressed: swapLanguages,
                icon: Icon(Icons.swap_horiz),
                color: Colors.grey[600],
                iconSize: 25,
              ),

              // Language 2 container with AnimatedSwitcher
              SizedBox(
                width: 150,
                child: AnimatedSwitcher(
                  duration: const Duration(
                      milliseconds: 500), // Set animation duration
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: animation.drive(
                        Tween<Offset>(
                            begin: Offset(0, 0), end: Offset(-1.5, 0)),
                      ),
                      child: child,
                    );
                  },
                  child: Container(
                    key: ValueKey<String>(widget.languagePair.language2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      widget.languagePair.language1,
                      style: const TextStyle(
                        color: AppColors.titleColor,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        fontFamily: AppFonts.fcr,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
