// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonModelImpl _$$LessonModelImplFromJson(Map<String, dynamic> json) =>
    _$LessonModelImpl(
      id: json['id'] as String,
      lessonName: json['lessonName'] as String,
      lessonId: json['lessonId'] as String,
      lessonImagePath: json['lessonImagePath'] as String,
    );

Map<String, dynamic> _$$LessonModelImplToJson(_$LessonModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonName': instance.lessonName,
      'lessonId': instance.lessonId,
      'lessonImagePath': instance.lessonImagePath,
    };
