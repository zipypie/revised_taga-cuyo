import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/entities/lesson_entity/lesson_entity.dart';

part 'lesson_model.freezed.dart';
part 'lesson_model.g.dart';

@freezed
class LessonModel with _$LessonModel {
  const factory LessonModel({
    required String id,
    required String lessonName,
    required String lessonId,
    required String lessonImagePath,
  }) = _LessonModel;

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  factory LessonModel.fromEntity(LessonEntity entity) {
    return LessonModel(
      id: entity.id,
      lessonName: entity.lessonName,
      lessonId: entity.lessonId,
      lessonImagePath: entity.lessonImagePath,
    );
  }
}
