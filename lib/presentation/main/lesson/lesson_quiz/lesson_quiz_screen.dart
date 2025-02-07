import 'package:flutter/material.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/fonts.dart';
import '../../../../core/constants/images.dart';

class LessonQuizScreen extends StatefulWidget {
  const LessonQuizScreen({super.key});

  @override
  State<LessonQuizScreen> createState() => _LessonQuizScreenState();
}

class _LessonQuizScreenState extends State<LessonQuizScreen> {
  String? selectedOption; // Track the selected option

  // List of options (you can fetch this dynamically)
  final List<String> options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Aralin 1', style: TextStyles.h2g), // TODO: Display lesson id
            Text(
              'Lesson Name',
              style: TextStyles.h1b,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              width: double.infinity,
              child: Text(
                textAlign: TextAlign.start,
                'Isalin ang pangungusap na ito.',
                style: TextStyles.knt18,
              ),
            ),
            _buildQuizContainer(context),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Text(
                      'Click the box to remove all the selected options',
                      style: TextStyles.knt16.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Selected Options Container
                    Container(
                      width: double.infinity,
                      height: ScreenUtils.getScreenHeight(context) * 0.2,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          selectedOption ?? 'No option selected',
                          style: TextStyles.h3b,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Pagpipilian',
                      style: TextStyles.h2b,
                    ),
                    const SizedBox(height: 10),
                    // Options Grid
                    Expanded(
                      child: _buildOptionsGrid(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: CustomButton(
                onTab: () {
                  // Handle "Check Answer" button tap
                  if (selectedOption != null) {
                    // Add logic to check the answer
                    print('Selected Option: $selectedOption');
                  }
                },
                text: 'Check Answer',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: 0.5, // Example progress value
                      backgroundColor: AppColors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text('1/2'), // Example progress text
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the options grid
  Widget _buildOptionsGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 options per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5, // Adjust the aspect ratio for better sizing
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return _buildOptionItem(options[index]);
      },
    );
  }

  // Build individual option item
  Widget _buildOptionItem(String option) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option; // Update the selected option
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedOption == option
              ? AppColors.primary // Highlight selected option
              : AppColors.accentColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color:
                selectedOption == option ? AppColors.primary : AppColors.grey,
          ),
        ),
        child: Center(
          child: Text(
            option,
            style: TextStyles.h3b.copyWith(
              color: selectedOption == option
                  ? AppColors.primaryBackground
                  : AppColors.titleColor,
            ),
          ),
        ),
      ),
    );
  }

  // Quiz Container (unchanged)
  Widget _buildQuizContainer(BuildContext context) {
    return Container(
      color: AppColors.secondaryBackground,
      width: ScreenUtils.getScreenWidth(context),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtils.getScreenWidth(context) * 0.5,
            child: Image.asset(LocalImages.teacher, fit: BoxFit.contain),
          ),
          Container(
            height: ScreenUtils.getScreenHeight(context) * 0.2,
            width: ScreenUtils.getScreenWidth(context) * 0.45,
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(7, 7),
                  spreadRadius: 0.2,
                  blurRadius: 10,
                  blurStyle: BlurStyle.inner,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Question here',
                style: TextStyles.h3b,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
