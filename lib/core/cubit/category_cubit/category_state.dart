part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;

  const CategoryLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class SubcategoryLoaded extends CategoryState {
  final List<SubcategoryModel> subcategories;

  const SubcategoryLoaded(this.subcategories);

  @override
  List<Object?> get props => [subcategories];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
