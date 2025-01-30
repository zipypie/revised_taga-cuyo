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

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FirebaseCategoryRepository _categoryRepository;
  final Map<String, String> _urlCache = {};
  int _score = 0;
  late Stopwatch _stopwatch;

  CategoryCubit(this._categoryRepository) : super(CategoryInitial()) {
    _stopwatch = Stopwatch();
  }

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await _categoryRepository.getCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError('Failed to load categories: $e'));
    }
  }

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

  Future<void> fetchWords(String subcategoryId, String categoryId) async {
    emit(CategoryLoading());
    try {
      final words =
          await _categoryRepository.getWords(subcategoryId, categoryId);
      if (words.isEmpty) {
        emit(WordsEmpty());
        return;
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
    final winRate =
        totalQuestions > 0 ? (_score / (totalQuestions * 50)) * 100 : 0;

    emit(QuizResultsComputed(
      score: _score,
      minutes: minutes,
      seconds: seconds,
      winRate: winRate.toStringAsFixed(2),
    ));
  }

  Duration get elapsed => _stopwatch.elapsed;
}
