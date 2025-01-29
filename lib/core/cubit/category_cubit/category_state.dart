part of 'category_cubit.dart';

/// Base class for all category-related states
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
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

  const WordsLoaded(this.words);

  @override
  List<Object?> get props => [words];
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

  const CheckAnswerResult({
    required this.isCorrect,
    required this.correctAnswer,
  });

  @override
  List<Object?> get props => [isCorrect, correctAnswer];
}
