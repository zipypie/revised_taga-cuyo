import 'dart:convert';

import 'package:equatable/equatable.dart';

class SubcategoryEntity extends Equatable {
  final String id; // Firestore document ID
  final String subCategoryId;
  final String subCategoryName;
  final String imagePath; // Property for image path

  const SubcategoryEntity({
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

  /// Copy Method
  SubcategoryEntity copyWith({
    String? id,
    String? subCategoryId,
    String? subCategoryName,
    String? imagePath,
  }) {
    return SubcategoryEntity(
      id: id ?? this.id,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Firestore document ID
      'subcategories_id': subCategoryId,
      'subcategories_name': subCategoryName,
      'image_path': imagePath, // Add imagePath to map
    };
  }

  /// Create from Map
  factory SubcategoryEntity.fromMap(
      Map<String, dynamic> map, String documentId) {
    return SubcategoryEntity(
      id: documentId, // Assign Firestore document ID
      subCategoryId: map['subcategories_id'] as String,
      subCategoryName: map['subcategories_name'] as String,
      imagePath: map['image_path'] as String, // Add imagePath from map
    );
  }

  /// Convert to JSON
  String toJson() => json.encode(toMap());

  /// Create from JSON
  factory SubcategoryEntity.fromJson(String source, String documentId) {
    return SubcategoryEntity.fromMap(
      json.decode(source) as Map<String, dynamic>,
      documentId, // Pass document ID
    );
  }
}
