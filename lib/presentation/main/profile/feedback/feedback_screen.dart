import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/animations/splash_animation.dart';
import 'package:taga_cuyo/core/common_widgets/popup%20displays/snackbar.dart';
import 'package:taga_cuyo/core/common_widgets/textfields/big_textfield.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/options_feedback.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/cubit/feedback_cubit/feedback_cubit.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/models/feedback_model.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';

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
      body: Stack(
        children: [
          SingleChildScrollView(
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
                  child: BlocConsumer<FeedbackCubit, FeedbackState>(
                    listener: (context, state) {
                      if (state is FeedbackFailure) {
                        showSnackBar(context, 'Error: ${state.error}');
                      } else if (state is FeedbackSuccess) {
                        showSnackBar(
                            context, 'Feedback submitted successfully!');
                      }
                    },
                    builder: (context, state) {
                      if (state is FeedbackLoading) {}
                      return CustomButton(
                        onTab: () {
                          final feedback = FeedbackModel(
                            rating: _rating.toDouble(),
                            selectedOptions: {
                              'ui_design': _selectedOptions[0],
                              'easy_navigation': _selectedOptions[1],
                              'content_features': _selectedOptions[2],
                              'learning_experience': _selectedOptions[3],
                            },
                            comments: _commentController.text,
                            timestamp: Timestamp.now(),
                          );
                          context
                              .read<FeedbackCubit>()
                              .submitFeedback(feedback);
                        },
                        text: 'Submit',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Add splash animation centered over the content when loading
          if (context.watch<FeedbackCubit>().state is FeedbackLoading)
            Center(
              child: SplashAnimation.loading(), // Optional: size adjustment
            ),
          // Add confetti animation after successful feedback submission
          if (context.watch<FeedbackCubit>().state is FeedbackSuccess)
            Center(
              child: SplashAnimation.confetti(
                height: ScreenUtils.getScreenHeight(context),
                width: ScreenUtils.getScreenWidth(context),
              ),
            ),
        ],
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
