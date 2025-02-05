import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_quiz_entity.freezed.dart';
part 'lesson_quiz_entity.g.dart';

@freezed
class LessonQuizEntity with _$LessonQuizEntity {
  const factory LessonQuizEntity({
    required List<String> options,
    required String translated,
    required String word,
  }) = _LessonQuizEntity;

  factory LessonQuizEntity.fromJson(Map<String, dynamic> json) =>
      _$LessonQuizEntityFromJson(json);

  factory LessonQuizEntity.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return LessonQuizEntity(
      options: List<String>.from(data['options'] ?? []), // Ensuring proper type
      translated: data['translated'] ?? '',
      word: data['word'] ?? '',
    );
  }
}
