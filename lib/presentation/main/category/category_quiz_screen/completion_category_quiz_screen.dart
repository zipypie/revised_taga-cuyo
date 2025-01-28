import 'package:flutter/material.dart';

class CompletionCategoryQuizScreen extends StatelessWidget {
  final String imageUrl;
  final int score;
  final int minutes;
  final double winRate;

  const CompletionCategoryQuizScreen({
    super.key,
    required this.imageUrl,
    required this.score,
    required this.minutes,
    required this.winRate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(imageUrl),
            SizedBox(height: 20),
            Text(
              'Score: $score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Time: $minutes minutes',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Win Rate: ${(winRate * 100).toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
