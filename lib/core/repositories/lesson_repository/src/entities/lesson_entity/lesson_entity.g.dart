// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonEntityImpl _$$LessonEntityImplFromJson(Map<String, dynamic> json) =>
    _$LessonEntityImpl(
      lessonName: json['lessonName'] as String,
      lessonId: json['lessonId'] as String,
      lessonImagePath: json['lessonImagePath'] as String,
    );

Map<String, dynamic> _$$LessonEntityImplToJson(_$LessonEntityImpl instance) =>
    <String, dynamic>{
      'lessonName': instance.lessonName,
      'lessonId': instance.lessonId,
      'lessonImagePath': instance.lessonImagePath,
    };
