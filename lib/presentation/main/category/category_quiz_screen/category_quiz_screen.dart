import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/common_widgets/selectables/button.dart';
import 'package:taga_cuyo/core/constants/capitalize.dart';
import 'package:taga_cuyo/core/constants/colors.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/models/categories_model.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/models/subcategories_model.dart';
import 'package:taga_cuyo/core/utils/screen_utils.dart';
import 'package:taga_cuyo/presentation/main/category/category_quiz_screen/close.dart';
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
  State<CategoryQuizScreen> createState() => _CategoryQuizScreenState();
}

class _CategoryQuizScreenState extends State<CategoryQuizScreen> {
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

    // Show the bottom sheet after checking the answer
    if (mounted) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allow content to be scrollable
        builder: (_) => CheckingScreen(
          isCorrect: isCorrect,
          correctAnswer: currentWord.translated,
        ),
      );

      // Proceed to the next question or handle end of quiz
      if (mounted) {
        if (currentIndex < words.length - 1) {
          setState(() {
            currentIndex++;
            selectedOption = null;
          });
        } else {
          Navigator.pop(context); // Back to the main screen
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WordsLoaded) {
            final words = state.words;
            if (words.isEmpty) {
              return const Center(child: Text('No words available.'));
            }

            final currentWord = words[currentIndex];

            return Stack(
              children: [
                Container(
                  width: ScreenUtils.getScreenWidth(context),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 45, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        capitalizeFirstLetter(widget.category.getCategoryName),
                        style: TextStyles.h2b.copyWith(color: AppColors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                          height: ScreenUtils.getScreenHeight(context) * 0.01),
                      Text(
                        capitalizeFirstLetter(
                            widget.subcategory.subCategoryName),
                        style: TextStyles.h1b,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: ScreenUtils.getScreenHeight(context) * 0.35,
                        decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: AppColors.accentColor, width: 12),
                        ),
                        child: Image.network(
                          currentWord.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.image,
                                  size: 50, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          capitalizeFirstLetter(currentWord.word),
                          style: TextStyles.h1b.copyWith(fontSize: 24),
                        ),
                      ),
                      SizedBox(
                          height: ScreenUtils.getScreenHeight(context) * 0.04),
                      ...currentWord.options.map((option) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOption = option;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: selectedOption == option
                                  ? AppColors.primary
                                  : AppColors.accentColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                capitalizeFirstLetter(option),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Opacity(
                        opacity: selectedOption != null
                            ? 1.0
                            : 0.3, // Full opacity when selected, 50% when not
                        child: CustomButton(
                          onTab: () => _checkAnswer(words),
                          text: 'Check Answer',
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      CloseScreen.showCloseBottomSheet(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: (currentIndex + 1) / words.length,
                          backgroundColor: AppColors.grey,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.accentColor),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text('${currentIndex + 1}/${words.length}'),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is CategoryError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const Center(child: Text('No data available.'));
        },
      )),
    );
  }
}
