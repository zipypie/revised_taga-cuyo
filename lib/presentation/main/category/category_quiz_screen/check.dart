// checking_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/cubit/category_cubit/category_cubit.dart';

class CheckingScreen extends StatelessWidget {
  final bool isCorrect;
  final String correctAnswer;
  final int index;
  final int maxIndex;
  final int score;
  final int minutes;
  final double winRate;
  final int seconds;

  const CheckingScreen({
    super.key,
    required this.isCorrect,
    required this.correctAnswer,
    required this.index,
    required this.maxIndex,
    required this.score,
    required this.minutes,
    required this.winRate,
    required this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isCorrect
          ? AppColors.correct.withValues(alpha: 0.3)
          : AppColors.wrong.withValues(alpha: 0.25),
      padding: const EdgeInsets.all(35),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                size: 50,
                color: isCorrect ? AppColors.correct : AppColors.wrong,
              ),
              const SizedBox(width: 10),
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
                  style: const TextStyle(
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
                  context.read<CategoryCubit>().nextQuestion();
                } else {
                  context.read<CategoryCubit>().nextQuestion();
                  Navigator.pop(context);
                }
              },
              text: index == maxIndex ? 'Finish' : 'Next',
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
