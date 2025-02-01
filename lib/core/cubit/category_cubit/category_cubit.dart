// category_cubit.dart
import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/category_repository.dart/src/firestore_user_progress_repository.dart';
import '../../repositories/category_repository.dart/src/models/models.dart';
import '../../repositories/category_repository.dart/src/models/subcategories_model.dart';
import '../../repositories/category_repository.dart/src/models/words_model.dart';
import '../../repositories/user_progress_repository/src/firestore_user_progress_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FirebaseCategoryRepository _categoryRepository;
  final FirebaseUserProgressRepository _userProgressRepository;
  final String userId;
  final Map<String, String> _urlCache = {};
  int _score = 0;
  late Stopwatch _stopwatch;
  int currentSubcategoryIndex = 0;
  CategoryModel? _currentCategory;
  SubcategoryModel? _currentSubcategory;

  CategoryCubit(
    this._categoryRepository,
    this._userProgressRepository,
    this.userId,
  ) : super(CategoryInitial()) {
    _stopwatch = Stopwatch();
  }

  // Fetch categories and their subcategories
  Future<void> fetchCategoriesWithSubcategories() async {
    emit(CategoryLoading());
    try {
      log('Fetching categories for user: $userId');
      final categories = await _categoryRepository.getCategories();
      final categoriesWithSubs =
          await Future.wait(categories.map((category) async {
        final subcategories =
            await _categoryRepository.getSubcategories(category.id);
        return CategoryWithSubcategories(category, subcategories);
      }));

      // Fetch completed categories count
      final completedCategoriesCountMap = await getCompletedCategoriesCount();

      emit(CategoriesWithSubcategoriesLoaded(
        categoriesWithSubs,
        currentSubcategoryIndex,
        completedCategoriesCountMap, // Pass the updated completed categories map
      ));
    } catch (e) {
      emit(CategoryError('Failed to load data: $e'));
    }
  }

  Future<Map<String, int>> getCompletedCategoriesCount() async {
    final completedCategoriesCountMap = <String, int>{};
    try {
      final quizData =
          await _userProgressRepository.getQuizCompletionData(userId);

      for (var quiz in quizData) {
        final categoryName = quiz.categoryName;

        // Track the number of completed subcategories for each category
        completedCategoriesCountMap.update(
          categoryName,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
    } catch (e) {
      log('Error fetching quiz completion data: $e');
    }
    return completedCategoriesCountMap;
  }

  Future<String?> getDownloadableUrl(String gsUrl) async {
    if (_urlCache.containsKey(gsUrl)) return _urlCache[gsUrl];
    try {
      final ref = FirebaseStorage.instance.refFromURL(gsUrl);
      final url = await ref.getDownloadURL();
      _urlCache[gsUrl] = url;
      return url;
    } catch (e) {
      log('Error getting download URL: $e');
      return null;
    }
  }

  Future<void> fetchWords({
    required CategoryModel category,
    required SubcategoryModel subcategory,
  }) async {
    emit(CategoryLoading());
    _currentCategory = category;
    _currentSubcategory = subcategory;

    try {
      final words = await _categoryRepository.getWords(
        subcategory.id,
        category.id,
      );

      // Shuffle the options for each word
      for (var word in words) {
        word.options.shuffle(); // Shuffle the options list of each word
      }

      _score = 0;
      _stopwatch
        ..reset()
        ..start();
      emit(WordsLoaded(words, 0));
    } catch (e) {
      emit(CategoryError('Failed to load words: $e'));
    }
  }

  void checkAnswer(String selectedOption, WordsModel currentWord) {
    if (state is! WordsLoaded) return;
    final currentState = state as WordsLoaded;

    final isCorrect = selectedOption == currentWord.translated;
    if (isCorrect) _score += 50;

    emit(CheckAnswerResult(
      score: _score,
      isCorrect: isCorrect,
      correctAnswer: currentWord.translated,
      currentIndex: currentState.currentIndex,
      words: currentState.words,
    ));
  }

  void nextQuestion() {
    if (state is! CheckAnswerResult) return;
    final currentState = state as CheckAnswerResult;

    if (currentState.currentIndex < currentState.words.length - 1) {
      emit(WordsLoaded(currentState.words, currentState.currentIndex + 1));
    } else {
      _completeQuiz(currentState.words.length);
    }
  }

  void _completeQuiz(int totalQuestions) {
    _stopwatch.stop();
    final totalSeconds = _stopwatch.elapsedMilliseconds ~/ 1000;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    // Calculate win rate as a percentage
    final winRate =
        totalQuestions > 0 ? (_score / (totalQuestions * 50)) * 100 : 0;

    // Calculate final score: Make sure we aren't dividing by 0 or negative time
    final finalScore = (minutes > 0 || seconds > 0)
        ? _score * (1 / (minutes * 60 + seconds)) * 10 // Inverse time scaling
        : _score; // If time is 0, use the raw score

    emit(QuizResultsComputed(
      score: finalScore.toInt(),
      minutes: minutes,
      seconds: seconds,
      winRate: winRate.toStringAsFixed(2),
    ));

    try {
      // Save quiz data
      if (_currentCategory != null && _currentSubcategory != null) {
        _userProgressRepository.saveQuizCompletionData(
          userId, // Use the authenticated user's ID
          _currentCategory!,
          _currentSubcategory!,
          finalScore.toInt(),
          minutes,
          seconds,
        );
      }
    } catch (e) {
      log('Error saving quiz data: $e');
    }
  }

  Duration get elapsed => _stopwatch.elapsed;
}
