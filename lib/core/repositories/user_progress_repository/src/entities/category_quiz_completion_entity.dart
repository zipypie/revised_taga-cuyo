import 'package:equatable/equatable.dart';

class CategoryQuizCompletionEntity extends Equatable {
  final String categoryName;
  final String subcategoryName;
  final int score;
  final int minutes;
  final int seconds;

  const CategoryQuizCompletionEntity({
    required this.categoryName,
    required this.subcategoryName,
    required this.score,
    required this.minutes,
    required this.seconds,
  });

  // Ensuring proper equality comparisons
  @override
  List<Object> get props =>
      [categoryName, subcategoryName, score, minutes, seconds];

  // CopyWith method to create modified copies of the object
  CategoryQuizCompletionEntity copyWith({
    String? categoryName,
    String? subcategoryName,
    int? score,
    int? minutes,
    int? seconds,
  }) {
    return CategoryQuizCompletionEntity(
      categoryName: categoryName ?? this.categoryName,
      subcategoryName: subcategoryName ?? this.subcategoryName,
      score: score ?? this.score,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
    );
  }

  // Converts object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'categoryName': categoryName,
      'subcategoryName': subcategoryName,
      'score': score,
      'minutes': minutes,
      'seconds': seconds,
    };
  }

  // Creates an object from a Firestore map
  factory CategoryQuizCompletionEntity.fromMap(Map<String, dynamic> map) {
    return CategoryQuizCompletionEntity(
      categoryName: map['categoryName'] ?? 'Unknown Category',
      subcategoryName: map['subcategoryName'] ?? 'Unknown Subcategory',
      score: (map['score'] ?? 0) as int,
      minutes: (map['minutes'] ?? 0) as int,
      seconds: (map['seconds'] ?? 0) as int,
    );
  }
}
