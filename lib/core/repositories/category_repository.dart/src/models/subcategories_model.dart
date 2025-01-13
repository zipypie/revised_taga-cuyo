import 'package:equatable/equatable.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/entities/subcategories_entity.dart';
import '../entities/words_entity.dart'; // Import SubcategoryEntity

class SubcategoryModel extends Equatable {
  final String subCategoryId;
  final String subCategoryName;
  final List<WordEntity> words; // List of WordEntities

  const SubcategoryModel({
    required this.subCategoryId,
    required this.subCategoryName,
    required this.words, // Ensure this is passed
  });

  @override
  List<Object?> get props => [
        subCategoryId,
        subCategoryName,
        words, // Add words to the equality check
      ];

  /// Empty SubcategoryModel Constant
  static const empty = SubcategoryModel(
    subCategoryId: '',
    subCategoryName: '',
    words: [], // Empty list of words
  );

  /// Copy Method
  SubcategoryModel copyWith({
    String? subCategoryId,
    String? subCategoryName,
    List<WordEntity>? words,
  }) {
    return SubcategoryModel(
      subCategoryId: subCategoryId ?? this.subCategoryId,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      words: words ?? this.words,
    );
  }

  /// Check if SubcategoryModel is Empty
  bool get isEmpty => this == SubcategoryModel.empty;

  /// Check if SubcategoryModel is Not Empty
  bool get isNotEmpty => this != SubcategoryModel.empty;

  /// Convert to SubcategoryEntity
  SubcategoryEntity toEntity() {
    return SubcategoryEntity(
      subCategoryId: subCategoryId,
      subCategoryName: subCategoryName,
      words: words, // Assuming you want to include words
    );
  }

  /// Convert from SubcategoryEntity
  static SubcategoryModel fromEntity(SubcategoryEntity entity) {
    return SubcategoryModel(
      subCategoryId: entity.subCategoryId,
      subCategoryName: entity.subCategoryName,
      words: entity.words, // Assuming entity contains words
    );
  }
}
