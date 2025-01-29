import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/category_repository.dart/src/firestore_user_progress_repository.dart';
import '../../repositories/category_repository.dart/src/models/models.dart';
import '../../repositories/category_repository.dart/src/models/subcategories_model.dart';
import '../../repositories/category_repository.dart/src/models/words_model.dart';

part 'category_state.dart';

// CategoryCubit
class CategoryCubit extends Cubit<CategoryState> {
  final FirebaseCategoryRepository _categoryRepository;

  CategoryCubit(this._categoryRepository) : super(CategoryInitial());

  // Fetch all categories
  Future<void> fetchCategories() async {
    try {
      emit(CategoryLoading());
      final categories = await _categoryRepository.getCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError('Failed to load categories: ${e.toString()}'));
    }
  }

  // Fetch subcategories for a specific category
  Future<void> fetchSubcategories(String categoryId) async {
    try {
      emit(CategoryLoading());
      final subcategories =
          await _categoryRepository.getSubcategories(categoryId);
      emit(SubcategoryLoaded(subcategories));
    } catch (e) {
      emit(CategoryError('Failed to load subcategories: ${e.toString()}'));
    }
  }

  Future<String?> getDownloadableUrl(String gsUrl) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(gsUrl);
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  Future<void> fetchWords(String subcategoryId, String categoryId) async {
    try {
      emit(CategoryLoading());
      final words =
          await _categoryRepository.getWords(subcategoryId, categoryId);
      emit(WordsLoaded(words));
    } catch (e) {
      emit(CategoryError('Failed to load words: ${e.toString()}'));
    }
  }

  Future<void> countWords(String subcategoryId, String categoryId) async {
    try {
      emit(CategoryLoading());
      final count =
          await _categoryRepository.countWords(subcategoryId, categoryId);
      emit(WordsCounted(count));
    } catch (e) {
      emit(CategoryError('Failed to count words: ${e.toString()}'));
    }
  }

  Future<void> checkAnswer({
    required String selectedOption,
    required WordsModel currentWord,
  }) async {
    try {
      final isCorrect = selectedOption == currentWord.translated;
      emit(CheckAnswerResult(
          isCorrect: isCorrect, correctAnswer: currentWord.translated));
    } catch (e) {
      emit(CategoryError('Failed to check answer: ${e.toString()}'));
    }
  }
}
