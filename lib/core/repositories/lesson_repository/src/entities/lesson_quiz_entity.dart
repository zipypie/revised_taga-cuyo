import 'dart:convert';
import 'package:equatable/equatable.dart';

/// Entity representing a lesson quiz in the application.
class LessonQuizEntity extends Equatable {
  final String lessonName;
  final String lessonId;
  final String lessonImagePath;
  final List<String> options;
  final String translated;
  final String word;

  const LessonQuizEntity({
    required this.lessonName,
    required this.lessonId,
    required this.lessonImagePath,
    required this.options,
    required this.translated,
    required this.word,
  });

  @override
  List<Object?> get props => [
        lessonName,
        lessonId,
        lessonImagePath,
        options,
        translated,
        word,
      ];

  /// Copy Method
  LessonQuizEntity copyWith({
    String? lessonName,
    String? lessonId,
    String? lessonImagePath,
    List<String>? options,
    String? translated,
    String? word,
  }) {
    return LessonQuizEntity(
      lessonName: lessonName ?? this.lessonName,
      lessonId: lessonId ?? this.lessonId,
      lessonImagePath: lessonImagePath ?? this.lessonImagePath,
      options: options ?? this.options,
      translated: translated ?? this.translated,
      word: word ?? this.word,
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'lesson_name': lessonName,
      'lesson_id': lessonId,
      'image_path': lessonImagePath,
      'options': options,
      'translated': translated,
      'word': word,
    };
  }

  /// Create from Map
  factory LessonQuizEntity.fromMap(Map<String, dynamic> map) {
    return LessonQuizEntity(
      lessonName: map['lesson_name'] as String,
      lessonId: map['lesson_id'] as String,
      lessonImagePath: map['image_path'] as String,
      options: List<String>.from(map['options'] ?? []),
      translated: map['translated'] as String,
      word: map['word'] as String,
    );
  }

  /// Convert to JSON
  String toJson() => json.encode(toMap());

  /// Create from JSON
  factory LessonQuizEntity.fromJson(String source) {
    return LessonQuizEntity.fromMap(
        json.decode(source) as Map<String, dynamic>);
  }
}
