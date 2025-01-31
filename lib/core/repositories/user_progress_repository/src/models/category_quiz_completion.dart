import 'package:equatable/equatable.dart';

import '../entities/category_quiz_completion_entity.dart';

class CategoryQuizCompletion extends Equatable {
  final String categoryName;
  final String subcategoryName;
  final int score;
  final int minutes;
  final int seconds;

  const CategoryQuizCompletion({
    required this.categoryName,
    required this.subcategoryName,
    required this.score,
    required this.minutes,
    required this.seconds,
  });

  @override
  List<Object?> get props => [
        categoryName,
        subcategoryName,
        score,
        minutes,
        seconds,
      ];

  static const empty = CategoryQuizCompletion(
    categoryName: 'Unknown Category',
    subcategoryName: 'Unknown Subcategory',
    score: 0,
    minutes: 0,
    seconds: 0,
  );

  CategoryQuizCompletion copyWith({
    String? categoryName,
    String? subcategoryName,
    int? score,
    int? minutes,
    int? seconds,
  }) {
    return CategoryQuizCompletion(
      categoryName: categoryName ?? this.categoryName,
      subcategoryName: subcategoryName ?? this.subcategoryName,
      score: score ?? this.score,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
    );
  }

  bool get isEmpty => this == CategoryQuizCompletion.empty;

  bool get isNotEmpty => this != CategoryQuizCompletion.empty;

  // Converts the model to an entity (for use with a repository or similar purposes)
  CategoryQuizCompletionEntity toEntity() {
    return CategoryQuizCompletionEntity(
      categoryName: categoryName,
      subcategoryName: subcategoryName,
      score: score,
      minutes: minutes,
      seconds: seconds,
    );
  }

  // Creates an instance from an entity
  static CategoryQuizCompletion fromEntity(
      CategoryQuizCompletionEntity entity) {
    return CategoryQuizCompletion(
      categoryName: entity.categoryName,
      subcategoryName: entity.subcategoryName,
      score: entity.score,
      minutes: entity.minutes,
      seconds: entity.seconds,
    );
  }
}
