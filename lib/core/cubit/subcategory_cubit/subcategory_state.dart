part of 'subcategory_cubit.dart';

sealed class SubcategoryState extends Equatable {
  const SubcategoryState();

  @override
  List<Object> get props => [];
}

final class SubcategoryInitial extends SubcategoryState {}

final class SubcategoryLoading extends SubcategoryState {}

final class SubcategoryLoaded extends SubcategoryState {
  final List<SubcategoryModel> subcategories;

  const SubcategoryLoaded(this.subcategories);

  @override
  List<Object> get props => [subcategories];
}

final class SubcategoryError extends SubcategoryState {
  final String message;

  const SubcategoryError(this.message);

  @override
  List<Object> get props => [message];
}
