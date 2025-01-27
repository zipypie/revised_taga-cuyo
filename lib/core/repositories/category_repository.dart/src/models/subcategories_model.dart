import 'package:equatable/equatable.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/entities/subcategories_entity.dart';

class SubcategoryModel extends Equatable {
  final String subCategoryId;
  final String subCategoryName;
  final String imagePath; // New property for image path

  const SubcategoryModel({
    required this.subCategoryId,
    required this.subCategoryName,
    required this.imagePath, // Initialize image path
  });

  @override
  List<Object?> get props => [
        subCategoryId,
        subCategoryName,
        imagePath, // Add imagePath to equality check
      ];

  /// Empty SubcategoryModel Constant
  static const empty = SubcategoryModel(
    subCategoryId: '',
    subCategoryName: '',
    imagePath: '', // Empty imagePath
  );

  /// Copy Method
  SubcategoryModel copyWith({
    String? subCategoryId,
    String? subCategoryName,
    String? imagePath,
  }) {
    return SubcategoryModel(
      subCategoryId: subCategoryId ?? this.subCategoryId,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  /// Convert to SubcategoryEntity
  SubcategoryEntity toEntity() {
    return SubcategoryEntity(
      subCategoryId: subCategoryId,
      subCategoryName: subCategoryName,
      imagePath: imagePath, // Include imagePath
    );
  }

  /// Convert from SubcategoryEntity
  static SubcategoryModel fromEntity(SubcategoryEntity entity) {
    return SubcategoryModel(
      subCategoryId: entity.subCategoryId,
      subCategoryName: entity.subCategoryName,
      imagePath: entity.imagePath, // Map imagePath
    );
  }
}
