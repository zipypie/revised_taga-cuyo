import 'dart:convert';
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int categoryId;
  final String categoryName;

  const CategoryEntity({
    required this.categoryId,
    required this.categoryName,
  });

  @override
  List<Object?> get props => [
        categoryId,
        categoryName,
      ];

  /// Copy Method
  CategoryEntity copyWith({
    int? categoryId,
    String? categoryName,
  }) {
    return CategoryEntity(
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
  factory CategoryEntity.fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      categoryId: map['category_id'] as int,
      categoryName: map['category_name'] as String,
    );
  }

  /// Convert to JSON
  String toJson() => json.encode(toMap());

  /// Create from JSON
  factory CategoryEntity.fromJson(String source) {
    return CategoryEntity.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
