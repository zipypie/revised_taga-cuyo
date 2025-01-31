part of 'category_cubit.dart';

/// Base class for all category-related states
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoriesWithSubcategoriesLoaded extends CategoryState {
  final List<CategoryWithSubcategories> categoriesWithSubcategories;
  final int currentSubcategoryIndex; // Assuming you need this

  const CategoriesWithSubcategoriesLoaded(
      this.categoriesWithSubcategories, this.currentSubcategoryIndex);

  @override
  List<Object?> get props =>
      [categoriesWithSubcategories, currentSubcategoryIndex];
}

class CategoryWithSubcategories {
  final CategoryModel category;
  final List<SubcategoryModel> subcategories;

  CategoryWithSubcategories(this.category, this.subcategories);
}

/// Initial state when no action has occurred
class CategoryInitial extends CategoryState {}

/// General loading state for categories, subcategories, or words
class CategoryLoading extends CategoryState {}

/// States related to Categories
class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;

  const CategoryLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}

/// States related to Subcategories
class SubcategoryLoading extends CategoryState {}

class SubcategoryLoaded extends CategoryState {
  final List<SubcategoryModel> subcategories;

  const SubcategoryLoaded(this.subcategories);

  @override
  List<Object?> get props => [subcategories];
}

class SubcategoryEmpty extends CategoryState {}

/// States related to Words
class WordsLoading extends CategoryState {}

class WordsLoaded extends CategoryState {
  final List<WordsModel> words;
  final int currentIndex;

  const WordsLoaded(this.words, this.currentIndex);

  @override
  List<Object?> get props => [words, currentIndex];
}

class WordsEmpty extends CategoryState {}

class WordsCounted extends CategoryState {
  final int count;

  const WordsCounted(this.count);

  @override
  List<Object?> get props => [count];
}

class CheckAnswerResult extends CategoryState {
  final bool isCorrect;
  final String correctAnswer;
  final int currentIndex;
  final List<WordsModel> words; // Add this
  final int score;

  const CheckAnswerResult({
    required this.score,
    required this.isCorrect,
    required this.correctAnswer,
    required this.currentIndex,
    required this.words, // Initialize this
  });

  @override
  List<Object> get props =>
      [score, isCorrect, correctAnswer, currentIndex, words];
}

class QuizResultsComputed extends CategoryState {
  final int score;
  final int minutes;
  final String winRate;
  final int seconds;

  const QuizResultsComputed({
    required this.score,
    required this.minutes,
    required this.winRate,
    required this.seconds,
  });

  @override
  List<Object> get props => [score, minutes, winRate];
}
