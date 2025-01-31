// category_quiz_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/constants/capitalize.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import '../../../../core/constants/fonts.dart';
import '../../../../core/cubit/category_cubit/category_cubit.dart';
import '../../../../core/repositories/category_repository.dart/src/models/models.dart';
import '../../../../core/repositories/category_repository.dart/src/models/subcategories_model.dart';
import '../../../../core/repositories/category_repository.dart/src/models/words_model.dart';
import 'check.dart';
import 'close.dart';
import 'completion_category_quiz_screen.dart';

class CategoryQuizScreen extends StatefulWidget {
  final SubcategoryModel subcategory;
  final CategoryModel category;

  const CategoryQuizScreen({
    super.key,
    required this.subcategory,
    required this.category,
  });

  @override
  State<CategoryQuizScreen> createState() => _CategoryQuizScreenState();
}

class _CategoryQuizScreenState extends State<CategoryQuizScreen> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    context
        .read<CategoryCubit>()
        .fetchWords(widget.subcategory.id, widget.category.id);
  }

  void _checkAnswer() {
    if (selectedOption == null) return;

    final cubit = context.read<CategoryCubit>();
    final state = cubit.state;

    if (state is WordsLoaded) {
      final currentWord = state.words[state.currentIndex];
      cubit.checkAnswer(selectedOption!, currentWord);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is CheckAnswerResult) {
              final cubit = context.read<CategoryCubit>();
              final elapsed = cubit.elapsed;
              final minutes = elapsed.inMinutes;
              final seconds = elapsed.inSeconds % 60;

              showModalBottomSheet(
                context: context,
                isDismissible: false,
                enableDrag: false,
                isScrollControlled: true,
                builder: (_) => CheckingScreen(
                  isCorrect: state.isCorrect,
                  correctAnswer: state.correctAnswer,
                  index: state.currentIndex,
                  maxIndex: state.words.length - 1,
                  score: state.score,
                  minutes: minutes,
                  seconds: seconds,
                  winRate: (state.score / (state.words.length * 50)) * 100,
                ),
              ).then((_) => setState(() => selectedOption = null));
            }
            if (state is QuizResultsComputed) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => CompletionCategoryQuizScreen(
                    score: state.score,
                    minutes: state.minutes,
                    seconds: state.seconds,
                    winRate: double.parse(state.winRate),
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CategoryError) {
                return Center(child: Text(state.message));
              }
              if (state is WordsLoaded || state is CheckAnswerResult) {
                // Extract current index and words based on the state type
                int currentIndex;
                List<WordsModel> words;
                if (state is WordsLoaded) {
                  currentIndex = state.currentIndex;
                  words = state.words;
                } else {
                  final resultState = state as CheckAnswerResult;
                  currentIndex = resultState.currentIndex;
                  words = resultState.words;
                }
                final currentWord = words[currentIndex];

                return Stack(
                  children: [
                    _buildQuizContent(
                        words, currentWord, currentIndex), // Pass currentIndex
                    _buildQuizControls(words.length, currentIndex),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: GestureDetector(
                        onTap: () => CloseScreen.showCloseBottomSheet(context),
                        child: const Icon(Icons.close, size: 30),
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: Text('No data available.'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuizContent(
    List<WordsModel> words,
    WordsModel currentWord,
    int currentIndex, // Receive currentIndex directly
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            capitalizeFirstLetter(widget.category.getCategoryName),
            style: TextStyles.h2b.copyWith(color: AppColors.grey),
          ),
          const SizedBox(height: 16),
          Text(
            capitalizeFirstLetter(widget.subcategory.subCategoryName),
            style: TextStyles.h1b,
          ),
          _buildImage(currentWord),
          _buildWordText(currentWord),
          _buildOptions(words, currentIndex), // Pass currentIndex
        ],
      ),
    );
  }

  Widget _buildImage(WordsModel currentWord) {
    return FutureBuilder<String?>(
      future: context
          .read<CategoryCubit>()
          .getDownloadableUrl(currentWord.imagePath),
      builder: (context, snapshot) {
        return Container(
          margin: const EdgeInsets.only(top: 20),
          height: ScreenUtils.getScreenHeight(context) * 0.35,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accentColor, width: 12),
          ),
          child: _buildImageContent(snapshot),
        );
      },
    );
  }

  Widget _buildImageContent(AsyncSnapshot<String?> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError || !snapshot.hasData) {
      return const Center(
          child: Icon(Icons.image, size: 50, color: Colors.grey));
    }
    return CachedNetworkImage(
      imageUrl: snapshot.data!,
      fit: BoxFit.cover,
      placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
      errorWidget: (_, __, ___) => const Center(child: Icon(Icons.image)),
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

  Widget _buildOptions(List<WordsModel> words, int currentIndex) {
    return Column(
      children: [
        SizedBox(height: ScreenUtils.getScreenHeight(context) * 0.04),
        ...words[currentIndex].options.map((option) => GestureDetector(
              onTap: () => setState(() => selectedOption = option),
              child: Container(
                margin: const EdgeInsets.only(top: 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              ),
            )),
        const SizedBox(height: 20),
        Opacity(
          opacity: selectedOption != null ? 1.0 : 0.3,
          child: CustomButton(
            onTab: _checkAnswer,
            text: 'Check Answer',
          ),
        ),
      ],
    );
  }

  Widget _buildQuizControls(int totalQuestions, int currentIndex) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: (currentIndex + 1) / totalQuestions,
              backgroundColor: AppColors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
            ),
          ),
          const SizedBox(width: 10),
          Text('${currentIndex + 1}/$totalQuestions'),
        ],
      ),
    );
  }
}
