import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/presentation/main/category/category_quiz_screen/report_screen.dart';
import '../../../../core/constants/capitalize.dart';
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
  final String categoryName;
  final String subcategoryName;
  final String userId; // Keep only this instance
  final String wordId;

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
    required this.categoryName,
    required this.subcategoryName,
    required this.userId,
    required this.wordId,
  });

  @override
  Widget build(BuildContext context) {
    final capitalizeAnswer = capitalizeFirstLetter(correctAnswer);
    return Container(
      color: isCorrect
          ? AppColors.correct.withValues(alpha: 0.3)
          : AppColors.wrong.withValues(alpha: 0.25),
      padding: const EdgeInsets.all(35),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        ? 'Your answer is Correct!'
                        : 'Your answer is Wrong!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isCorrect ? AppColors.correct : AppColors.wrong,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                  // Inside CheckingScreen's GestureDetector onTap
                  onTap: () {
                    final parentContext =
                        context; // Capture CheckingScreen's context
                    showDialog(
                      barrierDismissible: false,
                      context: parentContext,
                      builder: (BuildContext dialogContext) {
                        return ReportScreen(
                          parentContext: parentContext, // Pass parent context
                          userId: userId,
                          categoryName: categoryName,
                          subcategoryName: subcategoryName,
                          wordId: wordId,
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.bug_report_outlined,
                    size: 40,
                  )),
            ],
          ),
          if (!isCorrect)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: RichText(
                  text: TextSpan(
                      style:
                          const TextStyle(fontSize: 18, color: AppColors.wrong),
                      children: [
                        const TextSpan(text: 'The correct answer is: '),
                        TextSpan(
                            text: capitalizeAnswer,
                            style: TextStyle(fontWeight: FontWeight.bold))
                      ]),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: CustomButton(
              onTab: () {
                context.read<CategoryCubit>().nextQuestion();
                if (index != maxIndex) {
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
