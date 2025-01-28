import 'package:flutter/material.dart';

class CheckingScreen extends StatelessWidget {
  final bool isCorrect;
  final String correctAnswer;

  const CheckingScreen(
      {super.key, required this.isCorrect, required this.correctAnswer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              isCorrect ? 'Correct!' : 'Wrong!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isCorrect ? Colors.green : Colors.red,
              ),
            ),
            if (!isCorrect)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'The correct answer is: $correctAnswer',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
