import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/category_repository.dart/src/firestore_user_progress_repository.dart';
import '../../repositories/category_repository.dart/src/models/models.dart';
import '../../repositories/category_repository.dart/src/models/subcategories_model.dart';

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
}
