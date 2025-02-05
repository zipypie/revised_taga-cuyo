import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/entities/lesson_quiz_entity/lesson_quiz_entity.dart';

part 'lesson_quiz_model.freezed.dart';
part 'lesson_quiz_model.g.dart';

@freezed
class LessonQuizModel with _$LessonQuizModel {
  const factory LessonQuizModel({
    required List<String> options,
    required String translated,
    required String word,
  }) = _LessonQuizModel;

  factory LessonQuizModel.fromJson(Map<String, dynamic> json) =>
      _$LessonQuizModelFromJson(json);

  factory LessonQuizModel.fromEntity(LessonQuizEntity entity) {
    return LessonQuizModel(
      options: entity.options,
      translated: entity.translated,
      word: entity.word,
    );
  }
}
