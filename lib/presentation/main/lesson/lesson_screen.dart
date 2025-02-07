import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/constants/fonts.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/models/lesson_model/lesson_model.dart';
import 'package:taga_cuyo/presentation/main/lesson/lesson_quiz/lesson_quiz_screen.dart';
import '../../../core/constants/images.dart';
import '../../../core/cubit/lesson_cubit/lesson_cubit.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int _currentPageIndex = 0; // Track the current page index manually

  @override
  void initState() {
    super.initState();
    context
        .read<LessonCubit>()
        .getLessonWithCounts(); // Fetch lessons with counts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LessonCubit, LessonState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text("Initializing...")),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text("Error: $message")),
            success: (lessons) {
              // Fallback if successWithCounts is not implemented
              return _buildContent(lessons, null);
            },
            successWithCounts: (lessons, counts) {
              return _buildContent(lessons, counts);
            },
          );
        },
      ),
    );
  }

  Widget _buildContent(List<LessonModel> lessons, List<int>? counts) {
    if (lessons.isEmpty) {
      return const Center(child: Text("No lessons available"));
    }

    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: PageController(
                viewportFraction:
                    0.9, // Adjust this value to control the space between pages
              ),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                final lesson = lessons[index];
                final quizCount =
                    counts != null && counts.length > index ? counts[index] : 0;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _buildLessonUI(lesson, quizCount),
                );
              },
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index; // Update the current page index
                });
              },
            ),
          ),

          // Indicator (circles)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                lessons.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: _currentPageIndex == index
                        ? AppColors.primary // Active circle color
                        : AppColors.accentColor, // Inactive circle color
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonUI(LessonModel lesson, int quizCount) {
    return Column(
      children: [
        SizedBox(
          width: ScreenUtils.getScreenWidth(context),
          height: ScreenUtils.getScreenHeight(context) * 0.5,
          child: Image.network(
            lesson.lessonImagePath,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child; // Image has loaded
              } else {
                // Show a loading indicator while the image is loading
                return const Center(child: CircularProgressIndicator());
              }
            },
            errorBuilder: (context, error, stackTrace) {
              // Display a fallback image or error widget when the image fails to load
              return Image.asset(
                LocalImages.cashew1, // Use a local placeholder image
                fit: BoxFit.contain,
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
          width: ScreenUtils.getScreenWidth(context),
          height: ScreenUtils.getScreenHeight(context) * 0.3,
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Text(
                lesson.lessonName,
                textAlign: TextAlign.center, // Display lesson name
                style: TextStyles.h1b,
              ),
              const Spacer(),
              Text(
                'No. of Questions: $quizCount', // Dynamic quiz count
                style: TextStyles.h4n,
              ),
              CustomButton(
                onTab: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const LessonQuizScreen(),
                    ),
                  );
                },
                text: 'Enter',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
