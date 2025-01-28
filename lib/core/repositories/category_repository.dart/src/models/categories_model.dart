import 'package:equatable/equatable.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/entities/categories_entity.dart';

class CategoryModel extends Equatable {
  final String id; // Firestore Document ID
  final int categoryId; // Keep as int for the category ID
  final String categoryName;

  const CategoryModel({
    required this.id, // Document ID
    required this.categoryId,
    required this.categoryName,
  });

  @override
  List<Object?> get props => [
        id, // Include Firestore document ID in comparison
        categoryId,
        categoryName,
      ];

  String get getCategoryName => categoryName;

  /// Empty CategoryModel Constant
  static const empty = CategoryModel(
    id: '', // Empty document ID
    categoryId: 0, // Empty category ID
    categoryName: '',
  );

  /// Copy Method
  CategoryModel copyWith({
    String? id,
    int? categoryId,
    String? categoryName,
  }) {
    return CategoryModel(
      id: id ?? this.id, // Copy Firestore document ID
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
      id: id, // Pass the document ID to Entity
      categoryId: categoryId,
      categoryName: categoryName,
    );
  }

  static CategoryModel fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id, // Get document ID from the Entity
      categoryId: entity.categoryId,
      categoryName: entity.categoryName,
    );
  }
}
