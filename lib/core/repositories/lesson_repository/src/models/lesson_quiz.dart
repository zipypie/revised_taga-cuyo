import 'package:equatable/equatable.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/entities/lesson_quiz_entity.dart';

class LessonQuizModel extends Equatable {
  final String lessonName;
  final String lessonId;
  final String lessonImagePath;
  final List<String> options;
  final String translated;
  final String word;
  final bool isAnswered;
  final bool isCorrect;

  const LessonQuizModel({
    required this.lessonName,
    required this.lessonId,
    required this.lessonImagePath,
    required this.options,
    required this.translated,
    required this.word,
    this.isAnswered = false,
    this.isCorrect = false,
  });

  @override
  List<Object?> get props => [
        lessonName,
        lessonId,
        lessonImagePath,
        options,
        translated,
        word,
        isAnswered,
        isCorrect,
      ];

  LessonQuizModel copyWith({
    String? lessonName,
    String? lessonId,
    String? lessonImagePath,
    List<String>? options,
    String? translated,
    String? word,
    bool? isAnswered,
    bool? isCorrect,
  }) {
    return LessonQuizModel(
      lessonName: lessonName ?? this.lessonName,
      lessonId: lessonId ?? this.lessonId,
      lessonImagePath: lessonImagePath ?? this.lessonImagePath,
      options: options ?? this.options,
      translated: translated ?? this.translated,
      word: word ?? this.word,
      isAnswered: isAnswered ?? this.isAnswered,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  bool get isNotAnswered => !isAnswered;

  LessonQuizModel markAsAnswered({required String selectedOption}) {
    final bool correct = selectedOption == translated;
    return copyWith(isAnswered: true, isCorrect: correct);
  }

  bool isOptionCorrect(String option) {
    return option == translated;
  }

  /// Convert LessonQuizModel to LessonQuizEntity
  LessonQuizEntity toEntity() {
    return LessonQuizEntity(
      lessonName: lessonName,
      lessonId: lessonId,
      lessonImagePath: lessonImagePath,
      options: options,
      translated: translated,
      word: word,
    );
  }

  /// Convert from LessonQuizEntity to LessonQuizModel
  static LessonQuizModel fromEntity(LessonQuizEntity entity,
      {bool isAnswered = false, bool isCorrect = false}) {
    return LessonQuizModel(
      lessonName: entity.lessonName,
      lessonId: entity.lessonId,
      lessonImagePath: entity.lessonImagePath,
      options: entity.options,
      translated: entity.translated,
      word: entity.word,
      isAnswered: isAnswered,
      isCorrect: isCorrect,
    );
  }
}
