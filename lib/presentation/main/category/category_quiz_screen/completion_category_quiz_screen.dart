import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/constants/images.dart';

class CompletionCategoryQuizScreen extends StatelessWidget {
  final int score;
  final int minutes;
  final double winRate;
  final int seconds;

  const CompletionCategoryQuizScreen({
    super.key,
    required this.score,
    required this.minutes,
    required this.winRate,
    required this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(LocalImages.cashew1, height: 200), // Display image
                const SizedBox(height: 20),
                Text(
                  'Quiz Completed!',
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Time: $minutes minutes $seconds seconds',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  'Win Rate: ${winRate.toStringAsFixed(2)}%',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 30),
                CustomButton(
                    onTab: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    text: 'Back to Category'), // Add this
              ],
            ),
          ),
        ),
      ),
    );
  }
}
