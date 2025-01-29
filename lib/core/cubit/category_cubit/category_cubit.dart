import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/category_repository.dart/src/firestore_user_progress_repository.dart';
import '../../repositories/category_repository.dart/src/models/models.dart';
import '../../repositories/category_repository.dart/src/models/subcategories_model.dart';
import '../../repositories/category_repository.dart/src/models/words_model.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FirebaseCategoryRepository _categoryRepository;

  int _score = 0;
  int _totalQuestions = 0;
  late Stopwatch _stopwatch;

  CategoryCubit(this._categoryRepository) : super(CategoryInitial()) {
    _stopwatch = Stopwatch();
  }

  // Getter for score
  int get score => _score;

  // Fetch categories
  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await _categoryRepository.getCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError('Failed to load categories: $e'));
    }
  }

  // Fetch subcategories
  Future<void> fetchSubcategories(String categoryId) async {
    emit(CategoryLoading());
    try {
      final subcategories =
          await _categoryRepository.getSubcategories(categoryId);
      emit(SubcategoryLoaded(subcategories));
    } catch (e) {
      emit(CategoryError('Failed to load subcategories: $e'));
    }
  }

  // Get downloadable image URL
  Future<String?> getDownloadableUrl(String gsUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(gsUrl);
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  // Fetch words for the quiz
  Future<void> fetchWords(String subcategoryId, String categoryId) async {
    emit(CategoryLoading());
    try {
      final words =
          await _categoryRepository.getWords(subcategoryId, categoryId);
      if (words.isEmpty) {
        emit(CategoryError('No words available.'));
        return;
      }

      _totalQuestions = words.length;
      startQuiz(_totalQuestions);
      emit(WordsLoaded(words, 0)); // Initialize quiz with 0 index
    } catch (e) {
      emit(CategoryError('Failed to load words: $e'));
    }
  }

  // Start the quiz and reset timer/score
  void startQuiz(int totalQuestions) {
    _score = 0;
    _totalQuestions = totalQuestions;
    _stopwatch.reset();
    _stopwatch.start();
  }

  void checkAnswer(String selectedOption, WordsModel currentWord) {
    final isCorrect = selectedOption == currentWord.translated;
    if (isCorrect) _score += 50;

    if (state is! WordsLoaded) return;
    final currentState = state as WordsLoaded;

    // Emit the updated state with the new score
    emit(WordsLoaded(currentState.words, currentState.currentIndex));

    // Emit the result with the updated score after each answer check
    emit(CheckAnswerResult(
      isCorrect: isCorrect,
      correctAnswer: currentWord.translated,
      currentIndex: currentState.currentIndex,
      words: currentState.words,
      score: _score, // Pass the updated score here
    ));
  }

// Complete the quiz and calculate results
  void completeQuiz() {
    _stopwatch.stop();

    final totalSeconds = _stopwatch.elapsedMilliseconds ~/ 1000;
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    final winRate =
        _totalQuestions > 0 ? (_score / (_totalQuestions * 50)) : 0.0;
    final finalScore = (_score / ((minutes * 60) + seconds)) * 5;

    // Emit the final computed results
    emit(QuizResultsComputed(
      score: finalScore.toInt(),
      minutes: minutes,
      seconds: seconds,
      winRate:
          (winRate * 100).toStringAsFixed(2), // Convert win rate to percentage
    ));
  }
}
