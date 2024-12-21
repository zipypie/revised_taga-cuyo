import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/big_textfield.dart';
import 'package:taga_cuyo/core/common_widgets/button.dart';
import 'package:taga_cuyo/core/common_widgets/options_feedback.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  FeedbackScreenState createState() => FeedbackScreenState();
}

class FeedbackScreenState extends State<FeedbackScreen> {
  int _rating = 0;
  final List<bool> _selectedOptions = [false, false, false, false];
  final TextEditingController _commentController = TextEditingController();
  final List<String> optionTitles = [
    'User Interface and Design',
    'Easy Navigation',
    'Content and Features',
    'Learning Experience'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Share Your Feedback',
          style: TextStyles.h1b,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rate Your Experience', style: TextStyles.h2b),
            const SizedBox(height: 10),
            _buildRatingRow(),
            const SizedBox(height: 20),
            const Text('What did you like?', style: TextStyles.h2b),
            const SizedBox(height: 10),
            _buildOptionsList(),
            const SizedBox(height: 20),
            const Text('Your comments or suggestions (optional)',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 15),
            BigTextfield(
              controller: _commentController,
              hintText: 'Describe your experience here.',
              maxLines: 7,
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 20),
            Center(
              child: CustomButton(
                onTab: () async {
                  // await _submitFeedback();
                },
                text: 'Submit',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Refactored Rating Row to avoid repeating code
  Widget _buildRatingRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                _rating > index ? Icons.star : Icons.star_border,
                color: Colors.yellow,
              ),
              onPressed: () {
                setState(() {
                  _rating = index + 1;
                });
              },
            );
          }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) {
            return Text('${index + 1} star');
          }),
        ),
      ],
    );
  }

  // Dynamically generate the options list
  Widget _buildOptionsList() {
    return Column(
      children: List.generate(optionTitles.length, (index) {
        return CustomOption(
          title: optionTitles[index],
          index: index,
          isSelected: _selectedOptions[index],
          onTap: () {
            setState(() {
              _selectedOptions[index] = !_selectedOptions[index];
            });
          },
        );
      }),
    );
  }
}
