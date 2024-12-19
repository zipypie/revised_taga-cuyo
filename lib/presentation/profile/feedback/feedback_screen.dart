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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(top: 25),
          child: Text(
            'Share Your Feedback',
            style: TextStyles.h1b,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Rate Your Experience',
              style: TextStyles.h2b,
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            const Text(
              'What did you like?',
              style: TextStyles.h2b,
            ),
            const SizedBox(height: 10),
            // Now calling the CustomOption widget
            CustomOption(
              title: 'User Interface and Design',
              index: 0,
              isSelected: _selectedOptions[0],
              onTap: () {
                setState(() {
                  _selectedOptions[0] = !_selectedOptions[0];
                });
              },
            ),
            CustomOption(
              title: 'Easy Navigation',
              index: 1,
              isSelected: _selectedOptions[1],
              onTap: () {
                setState(() {
                  _selectedOptions[1] = !_selectedOptions[1];
                });
              },
            ),
            CustomOption(
              title: 'Content and Features',
              index: 2,
              isSelected: _selectedOptions[2],
              onTap: () {
                setState(() {
                  _selectedOptions[2] = !_selectedOptions[2];
                });
              },
            ),
            CustomOption(
              title: 'Learning Experience',
              index: 3,
              isSelected: _selectedOptions[3],
              onTap: () {
                setState(() {
                  _selectedOptions[3] = !_selectedOptions[3];
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Your comments or suggestions (optional)',
              style: TextStyle(fontSize: 16),
            ),
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
}
