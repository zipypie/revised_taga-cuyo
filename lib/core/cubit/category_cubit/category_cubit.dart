import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/category_repository.dart/src/firestore_user_progress_repository.dart';
import '../../repositories/category_repository.dart/src/models/models.dart';
import '../../repositories/category_repository.dart/src/models/subcategories_model.dart';

part 'category_state.dart';

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

  // Fetch categories by categoryId
  Future<void> fetchCategoriesById(String categoryId) async {
    try {
      emit(CategoryLoading());
      final categories =
          await _categoryRepository.getCategoriesById(categoryId);
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError('Failed to load categories: ${e.toString()}'));
    }
  }

  // Fetch subcategories by categoryId
  Future<void> fetchSubCategories(String categoryId) async {
    try {
      emit(CategoryLoading());
      final subCategories =
          await _categoryRepository.getSubcategories(categoryId);
      emit(SubcategoryLoaded(subCategories));
    } catch (e) {
      emit(CategoryError('Failed to load subcategories: ${e.toString()}'));
    }
  }
}
