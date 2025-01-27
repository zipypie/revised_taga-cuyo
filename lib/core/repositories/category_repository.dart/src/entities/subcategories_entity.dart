import 'dart:convert';

import 'package:equatable/equatable.dart';

class SubcategoryEntity extends Equatable {
  final String subCategoryId;
  final String subCategoryName;
  final String imagePath; // Property for image path

  const SubcategoryEntity({
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

  /// Copy Method
  SubcategoryEntity copyWith({
    String? subCategoryId,
    String? subCategoryName,
    String? imagePath,
  }) {
    return SubcategoryEntity(
      subCategoryId: subCategoryId ?? this.subCategoryId,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'subcategories_id': subCategoryId,
      'subcategories_name': subCategoryName,
      'image_path': imagePath, // Add imagePath to map
    };
  }

  /// Create from Map
  factory SubcategoryEntity.fromMap(
      Map<String, dynamic> map, String subCategoryId) {
    return SubcategoryEntity(
      subCategoryId: subCategoryId,
      subCategoryName: map['subcategories_name'] as String,
      imagePath: map['image_path'] as String, // Add imagePath from map
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
