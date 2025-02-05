// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonQuizModelImpl _$$LessonQuizModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LessonQuizModelImpl(
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      translated: json['translated'] as String,
      word: json['word'] as String,
    );

Map<String, dynamic> _$$LessonQuizModelImplToJson(
        _$LessonQuizModelImpl instance) =>
    <String, dynamic>{
      'options': instance.options,
      'translated': instance.translated,
      'word': instance.word,
    };
