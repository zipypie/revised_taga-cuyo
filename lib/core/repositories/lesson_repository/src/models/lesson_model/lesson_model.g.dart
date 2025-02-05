// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonModelImpl _$$LessonModelImplFromJson(Map<String, dynamic> json) =>
    _$LessonModelImpl(
      lessonName: json['lessonName'] as String,
      lessonId: json['lessonId'] as String,
      lessonImagePath: json['lessonImagePath'] as String,
    );

Map<String, dynamic> _$$LessonModelImplToJson(_$LessonModelImpl instance) =>
    <String, dynamic>{
      'lessonName': instance.lessonName,
      'lessonId': instance.lessonId,
      'lessonImagePath': instance.lessonImagePath,
    };
