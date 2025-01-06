import 'dart:convert';

import 'package:flutter/foundation.dart';

/// This model is the collection of Lessons
/// and the variables here are fields inside every document.
class LessonModel {
  String lessonName;
  String lessonId;
  String lessonImagePath;

  LessonModel({
    required this.lessonName,
    required this.lessonId,
    required this.lessonImagePath,
  });

  LessonModel copyWith({
    String? lessonName,
    String? lessonId,
    String? lessonImagePath,
  }) {
    return LessonModel(
      lessonName: lessonName ?? this.lessonName,
      lessonId: lessonId ?? this.lessonId,
      lessonImagePath: lessonImagePath ?? this.lessonImagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lesson_name': lessonName,
      'lesson_id': lessonId,
      'image_path': lessonImagePath,
    };
  }

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    try {
      return LessonModel(
        lessonName: map['lesson_name'] as String,
        lessonId: map['lesson_id'] as String,
        lessonImagePath: map['image_path'] as String,
      );
    } catch (e) {
      throw FormatException("Error parsing LessonModel from map: $e");
    }
  }

  String toJson() => json.encode(toMap());

  factory LessonModel.fromJson(String source) {
    try {
      return LessonModel.fromMap(json.decode(source) as Map<String, dynamic>);
    } catch (e) {
      throw FormatException("Error parsing LessonModel from JSON: $e");
    }
  }

  @override
  String toString() =>
      'LessonModel(lesson_name: $lessonName, lesson_id: $lessonId, image_path: $lessonImagePath)';

  @override
  bool operator ==(covariant LessonModel other) {
    if (identical(this, other)) return true;

    return other.lessonName == lessonName &&
        other.lessonId == lessonId &&
        other.lessonImagePath == lessonImagePath;
  }

  @override
  int get hashCode =>
      lessonName.hashCode ^ lessonId.hashCode ^ lessonImagePath.hashCode;
}

// This model is inside the collection of words, and the parent collection is the lessons.
// Each document in the lessons collection has a words collection, and inside that words collection is this LessonQuizModel.
class LessonQuizModel extends LessonModel {
  List<String> options; // This field has an array inside the Firestore database
  String translated;
  String word;

  LessonQuizModel({
    required super.lessonName,
    required super.lessonId,
    required super.lessonImagePath,
    required this.options,
    required this.translated,
    required this.word,
  });

  @override
  LessonQuizModel copyWith({
    String? lessonName,
    String? lessonId,
    String? lessonImagePath,
    List<String>? options,
    String? translated,
    String? word,
  }) {
    return LessonQuizModel(
      lessonName: lessonName ?? this.lessonName,
      lessonId: lessonId ?? this.lessonId,
      lessonImagePath: lessonImagePath ?? this.lessonImagePath,
      options: options ?? this.options,
      translated: translated ?? this.translated,
      word: word ?? this.word,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'options': options,
      'translated': translated,
      'word': word,
    });
    return map;
  }

  factory LessonQuizModel.fromMap(Map<String, dynamic> map) {
    try {
      return LessonQuizModel(
        lessonName: map['lesson_name'] as String,
        lessonId: map['lesson_id'] as String,
        lessonImagePath: map['image_path'] as String,
        options: List<String>.from(
            map['options'] ?? []), // safely handle empty or missing options
        translated: map['translated'] as String,
        word: map['word'] as String,
      );
    } catch (e) {
      throw FormatException("Error parsing LessonQuizModel from map: $e");
    }
  }

  @override
  String toJson() => json.encode(toMap());

  factory LessonQuizModel.fromJson(String source) {
    try {
      return LessonQuizModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
    } catch (e) {
      throw FormatException("Error parsing LessonQuizModel from JSON: $e");
    }
  }

  @override
  String toString() {
    return 'LessonQuizModel(lesson_name: $lessonName, lesson_id: $lessonId, image_path: $lessonImagePath, options: $options, translated: $translated, word: $word)';
  }

  @override
  bool operator ==(covariant LessonQuizModel other) {
    if (identical(this, other)) return true;
    return super == other &&
        listEquals(other.options, options) &&
        other.translated == translated &&
        other.word == word;
  }

  @override
  int get hashCode =>
      super.hashCode ^ options.hashCode ^ translated.hashCode ^ word.hashCode;
}
