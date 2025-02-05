// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_quiz_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonQuizEntityImpl _$$LessonQuizEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$LessonQuizEntityImpl(
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      translated: json['translated'] as String,
      word: json['word'] as String,
    );

Map<String, dynamic> _$$LessonQuizEntityImplToJson(
        _$LessonQuizEntityImpl instance) =>
    <String, dynamic>{
      'options': instance.options,
      'translated': instance.translated,
      'word': instance.word,
    };
