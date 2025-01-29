import 'package:equatable/equatable.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/entities/subcategories_entity.dart';

class SubcategoryModel extends Equatable {
  final String id; // Firestore document ID
  final String subCategoryId;
  final String subCategoryName;
  final String imagePath; // New property for image path

  const SubcategoryModel({
    required this.id, // Firestore document ID
    required this.subCategoryId,
    required this.subCategoryName,
    required this.imagePath, // Initialize image path
  });

  @override
  List<Object?> get props => [
        id, // Include Firestore document ID in equality check
        subCategoryId,
        subCategoryName,
        imagePath, // Add imagePath to equality check
      ];

  /// Empty SubcategoryModel Constant
  static const empty = SubcategoryModel(
    id: '', // Empty Firestore document ID
    subCategoryId: '',
    subCategoryName: '',
    imagePath: '', // Empty imagePath
  );

  /// Copy Method
  SubcategoryModel copyWith({
    String? id,
    String? subCategoryId,
    String? subCategoryName,
    String? imagePath,
  }) {
    return SubcategoryModel(
      id: id ?? this.id,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  /// Convert to SubcategoryEntity
  SubcategoryEntity toEntity() {
    return SubcategoryEntity(
      id: id, // Include Firestore document ID
      subCategoryId: subCategoryId,
      subCategoryName: subCategoryName,
      imagePath: imagePath, // Include imagePath
    );
  }

  /// Convert from SubcategoryEntity
  static SubcategoryModel fromEntity(SubcategoryEntity entity) {
    return SubcategoryModel(
      id: entity.id, // Map Firestore document ID
      subCategoryId: entity.subCategoryId,
      subCategoryName: entity.subCategoryName,
      imagePath: entity.imagePath, // Map imagePath
    );
  }
}
