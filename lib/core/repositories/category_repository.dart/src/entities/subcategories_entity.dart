import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:taga_cuyo/core/repositories/category_repository.dart/src/entities/words_entity.dart';

class SubcategoryEntity extends Equatable {
  final String subCategoryId;
  final String subCategoryName;
  final List<WordEntity> words; // List of WordEntities

  const SubcategoryEntity({
    required this.subCategoryId,
    required this.subCategoryName,
    required this.words, // Initialize the list of words
  });

  @override
  List<Object?> get props => [
        subCategoryId,
        subCategoryName,
        words,
      ];

  /// Copy Method
  SubcategoryEntity copyWith({
    String? subCategoryId,
    String? subCategoryName,
    List<WordEntity>? words,
  }) {
    return SubcategoryEntity(
      subCategoryId: subCategoryId ?? this.subCategoryId,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      words: words ?? this.words,
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'sub_category_id': subCategoryId,
      'sub_category_name': subCategoryName,
      'words': words.map((e) => e.toMap()).toList(), // Convert list of words
    };
  }

  /// Create from Map
  factory SubcategoryEntity.fromMap(
      Map<String, dynamic> map, String subCategoryId) {
    return SubcategoryEntity(
      subCategoryId: subCategoryId,
      subCategoryName: map['sub_category_name'] as String,
      words: List<WordEntity>.from(
        (map['words'] as List).map(
          (wordData) => WordEntity.fromMap(
              wordData['word_id'] as String, wordData as Map<String, dynamic>),
        ),
      ), // Convert map to list of WordEntity
    );
  }

  /// Convert to JSON
  String toJson() => json.encode(toMap());

  /// Create from JSON
  factory SubcategoryEntity.fromJson(String source) {
    return SubcategoryEntity.fromMap(
      json.decode(source) as Map<String, dynamic>,
      source, // Assuming source contains the subCategoryId
    );
  }
}
