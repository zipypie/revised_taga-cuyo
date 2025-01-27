import 'dart:convert';
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id; // Document ID
  final int categoryId; // categoryId
  final String categoryName;

  const CategoryEntity({
    required this.id, // Document ID
    required this.categoryId,
    required this.categoryName,
  });

  @override
  List<Object?> get props => [
        id, // Include the document ID in equality check
        categoryId,
        categoryName,
      ];

  /// Copy Method
  CategoryEntity copyWith({
    String? id,
    int? categoryId,
    String? categoryName,
  }) {
    return CategoryEntity(
      id: id ?? this.id, // Copy document ID
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
    };
  }

  /// Create from Map
  factory CategoryEntity.fromMap(Map<String, dynamic> map,
      {required String id}) {
    return CategoryEntity(
      id: id, // Assign Firestore document ID here
      categoryId: map['category_id'] as int,
      categoryName: map['category_name'] as String,
    );
  }

  /// Convert to JSON
  String toJson() => json.encode(toMap());

  /// Create from JSON
  factory CategoryEntity.fromJson(String source) {
    return CategoryEntity.fromMap(json.decode(source) as Map<String, dynamic>,
        id: '');
  }
}
