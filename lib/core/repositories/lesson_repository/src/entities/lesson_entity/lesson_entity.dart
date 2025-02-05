import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_entity.freezed.dart';
part 'lesson_entity.g.dart';

@freezed
class LessonEntity with _$LessonEntity {
  const factory LessonEntity({
    required String lessonName,
    required String lessonId,
    required String lessonImagePath,
  }) = _LessonEntity;

  factory LessonEntity.fromJson(Map<String, dynamic> json) =>
      _$LessonEntityFromJson(json);

  factory LessonEntity.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return LessonEntity(
      lessonName: data['lesson_name'],
      lessonId: data['lesson_id'],
      lessonImagePath: data['image_path'],
    );
  }
}
