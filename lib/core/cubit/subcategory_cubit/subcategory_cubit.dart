import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/models/subcategories_model.dart';

import '../../repositories/subcategory_repository.dart/src/firestore_subcategory_repository.dart';

part 'subcategory_state.dart';

class SubcategoryCubit extends Cubit<SubcategoryState> {
  final FirebaseSubCategoryRepository _subcategoryRepository;
  SubcategoryCubit(this._subcategoryRepository) : super(SubcategoryInitial());

  // Fetch all categories
  Future<void> fetchCategories() async {
    try {
      emit(SubcategoryLoading());

      // emit(SubcategoryLoaded());
    } catch (e) {
      emit(SubcategoryError('Failed to load categories: ${e.toString()}'));
    }
  }
}
