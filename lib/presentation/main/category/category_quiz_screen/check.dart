import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';

import '../../../../core/constants/colors.dart';
import 'completion_category_quiz_screen.dart'; // Import the CompletionCategoryQuizScreen

class CheckingScreen extends StatelessWidget {
  final bool isCorrect;
  final String correctAnswer;
  final int index; // Current question index
  final int maxIndex; // Total number of questions (max index)
  final int score; // Current score
  final int minutes; // Time in minutes
  final double winRate; // Win rate percentage
  final int seconds; // Time in seconds

  const CheckingScreen({
    super.key,
    required this.isCorrect,
    required this.correctAnswer,
    required this.index, // Current index
    required this.maxIndex, // Maximum index value
    required this.score, // Pass actual score here
    required this.minutes, // Pass actual time here
    required this.winRate, // Calculate actual win rate here
    required this.seconds, // Pass actual seconds here
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isCorrect
          ? AppColors.correct.withValues(alpha: 0.4)
          : AppColors.wrong.withValues(alpha: 0.25),
      padding: const EdgeInsets.all(35),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Minimize the size of the modal
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Center the content
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                size: 50,
                color: isCorrect ? AppColors.correct : AppColors.wrong,
              ),
              SizedBox(width: 10), // Add space between icon and text
              Text(
                isCorrect
                    ? 'Great! Your answer is Correct!'
                    : 'Your answer is Wrong!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isCorrect ? AppColors.correct : AppColors.wrong,
                ),
              ),
            ],
          ),
          if (!isCorrect)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Text(
                  'The correct answer is: $correctAnswer',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.wrong,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CustomButton(
              onTab: () {
                if (index == maxIndex) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompletionCategoryQuizScreen(
                        score: score, // Pass actual score here
                        minutes: minutes, // Pass actual time here
                        winRate: winRate, // Pass actual win rate here
                        seconds: seconds, // Pass actual seconds here
                      ),
                    ),
                  );
                } else {
                  Navigator.pop(context); // Close the bottom sheet
                }
              },
              text: 'Next',
              textColor: isCorrect
                  ? AppColors.primaryBackground
                  : AppColors.titleColor,
              backgroundColor: isCorrect ? AppColors.correct : AppColors.wrong,
            ),
          ),
        ],
      ),
    );
  }
}
