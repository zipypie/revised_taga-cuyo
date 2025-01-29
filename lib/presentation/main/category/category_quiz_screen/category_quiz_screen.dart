import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/constants/capitalize.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/models/categories_model.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/models/subcategories_model.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import 'package:taga_cuyo/presentation/main/category/category_quiz_screen/completion_category_quiz_screen.dart';
import '../../../../core/constants/fonts.dart';
import '../../../../core/cubit/category_cubit/category_cubit.dart';
import '../../../../core/repositories/category_repository.dart/src/models/words_model.dart';
import 'check.dart';

class CategoryQuizScreen extends StatefulWidget {
  final SubcategoryModel subcategory;
  final CategoryModel category;

  const CategoryQuizScreen({
    super.key,
    required this.subcategory,
    required this.category,
  });

  @override
  CategoryQuizScreenState createState() => CategoryQuizScreenState();
}

class CategoryQuizScreenState extends State<CategoryQuizScreen> {
  int currentIndex = 0;
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    context
        .read<CategoryCubit>()
        .fetchWords(widget.subcategory.id, widget.category.id);
  }

  void _checkAnswer(List<WordsModel> words) async {
    if (selectedOption == null) return;

    final currentWord = words[currentIndex];
    final isCorrect = selectedOption == currentWord.translated;

    // Show result in bottom sheet
    if (mounted) {
      // Fetch the current values from the Cubit state
      final currentState = context.read<CategoryCubit>().state;
      final currentScore =
          (currentState is QuizResultsComputed) ? currentState.score : 0;
      final currentMinutes =
          (currentState is QuizResultsComputed) ? currentState.minutes : 0;
      final currentSeconds =
          (currentState is QuizResultsComputed) ? currentState.seconds : 0;
      final currentWinRate =
          (currentState is QuizResultsComputed) ? currentState.winRate : 0.0;

      showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        builder: (_) => CheckingScreen(
          isCorrect: isCorrect,
          correctAnswer: currentWord.translated,
          index: currentIndex, // current index of the question
          maxIndex: words.length, // total number of questions
          score: currentScore, // Pass the updated score here
          minutes: currentMinutes,
          winRate: currentWinRate as double,
          seconds: currentSeconds,
        ),
      );

      if (mounted) {
        if (currentIndex < words.length - 1) {
          setState(() {
            currentIndex++;
            selectedOption = null;
          });
        } else {
          context.read<CategoryCubit>().completeQuiz(); // Complete the quiz
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is QuizResultsComputed) {
              // Navigate to CompletionCategoryQuizScreen when the quiz is completed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CompletionCategoryQuizScreen(
                    score: state.score,
                    minutes: state.minutes,
                    winRate:
                        double.parse(state.winRate), // Ensure this is a double
                    seconds: state.seconds,
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WordsLoaded) {
                final words = state.words;
                if (words.isEmpty) {
                  return const Center(child: Text('No words available.'));
                }

                final currentWord = words[currentIndex];

                // Get the current score from the cubit
                final currentScore = context.read<CategoryCubit>().score;

                return Stack(
                  children: [
                    _buildQuizContent(words, currentWord),
                    _buildQuizControls(
                        words, currentScore), // Pass score to controls
                  ],
                );
              } else if (state is CategoryError) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return const Center(child: Text('No data available.'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuizContent(List<WordsModel> words, WordsModel currentWord) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            capitalizeFirstLetter(widget.category.getCategoryName),
            style: TextStyles.h2b.copyWith(color: AppColors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            capitalizeFirstLetter(widget.subcategory.subCategoryName),
            style: TextStyles.h1b,
            textAlign: TextAlign.center,
          ),
          _buildImage(currentWord),
          _buildWordText(currentWord),
          _buildOptions(words),
        ],
      ),
    );
  }

  Widget _buildImage(WordsModel currentWord) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: ScreenUtils.getScreenHeight(context) * 0.35,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accentColor, width: 12),
      ),
      child: Image.network(
        currentWord.imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
              child: Icon(Icons.image, size: 50, color: Colors.grey));
        },
      ),
    );
  }

  Widget _buildWordText(WordsModel currentWord) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Text(
        capitalizeFirstLetter(currentWord.word),
        style: TextStyles.h1b.copyWith(fontSize: 24),
      ),
    );
  }

  Widget _buildOptions(List<WordsModel> words) {
    return Column(
      children: [
        SizedBox(height: ScreenUtils.getScreenHeight(context) * 0.04),
        ...words[currentIndex].options.map((option) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedOption = option;
              });
            },
            child: _buildOptionButton(option),
          );
        }),
        const SizedBox(height: 20),
        Opacity(
          opacity: selectedOption != null ? 1.0 : 0.3,
          child: CustomButton(
              onTab: () => _checkAnswer(words), text: 'Check Answer'),
        ),
      ],
    );
  }

  Widget _buildOptionButton(String option) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: selectedOption == option
            ? AppColors.primary
            : AppColors.accentColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          capitalizeFirstLetter(option),
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildQuizControls(List<WordsModel> words, int currentScore) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: (currentIndex + 1) / words.length,
              backgroundColor: AppColors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
            ),
          ),
          const SizedBox(width: 10),
          Text('${currentIndex + 1}/${words.length}'),
        ],
      ),
    );
  }
}
