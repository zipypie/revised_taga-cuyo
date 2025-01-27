import 'package:equatable/equatable.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/entities/categories_entity.dart';

class CategoryModel extends Equatable {
  final int categoryId; // Keep as int
  final String categoryName;

  const CategoryModel({
    required this.categoryId,
    required this.categoryName,
  });

  @override
  List<Object?> get props => [
        categoryId,
        categoryName,
      ];

  /// Empty CategoryModel Constant
  static const empty = CategoryModel(
    categoryId: 0, // Change to int
    categoryName: '',
  );

  /// Copy Method
  CategoryModel copyWith({
    int? categoryId, // Keep as int
    String? categoryName,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  /// Check if CategoryModel is Empty
  bool get isEmpty => this == CategoryModel.empty;

  /// Check if CategoryModel is Not Empty
  bool get isNotEmpty => this != CategoryModel.empty;

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      categoryName: categoryName,
    );
  }

  static CategoryModel fromEntity(CategoryEntity entity) {
    return CategoryModel(
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
    );
  }
}
