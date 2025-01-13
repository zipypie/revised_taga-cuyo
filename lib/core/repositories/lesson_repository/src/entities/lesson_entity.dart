import 'dart:convert';
import 'package:equatable/equatable.dart';

/// Entity representing a lesson in the application.
class LessonEntity extends Equatable {
  final String lessonName;
  final String lessonId;
  final String lessonImagePath;

  const LessonEntity({
    required this.lessonName,
    required this.lessonId,
    required this.lessonImagePath,
  });

  @override
  List<Object?> get props => [lessonName, lessonId, lessonImagePath];

  /// Copy Method
  LessonEntity copyWith({
    String? lessonName,
    String? lessonId,
    String? lessonImagePath,
  }) {
    return LessonEntity(
      lessonName: lessonName ?? this.lessonName,
      lessonId: lessonId ?? this.lessonId,
      lessonImagePath: lessonImagePath ?? this.lessonImagePath,
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'lesson_name': lessonName,
      'lesson_id': lessonId,
      'image_path': lessonImagePath,
    };
  }

  /// Create from Map
  factory LessonEntity.fromMap(Map<String, dynamic> map) {
    return LessonEntity(
      lessonName: map['lesson_name'] as String,
      lessonId: map['lesson_id'] as String,
      lessonImagePath: map['image_path'] as String,
    );
  }

  /// Convert to JSON
  String toJson() => json.encode(toMap());

  /// Create from JSON
  factory LessonEntity.fromJson(String source) {
    return LessonEntity.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
