import 'package:equatable/equatable.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/entities/lesson_entity.dart';

class Lesson extends Equatable {
  final String id;
  final String name;
  final String imagePath;
  final String description;

  const Lesson({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, imagePath, description];

  static const empty = Lesson(
    id: '',
    name: '',
    imagePath: '',
    description: '',
  );

  Lesson copyWith({
    String? id,
    String? name,
    String? imagePath,
    String? description,
  }) {
    return Lesson(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
    );
  }

  bool get isEmpty => this == Lesson.empty;

  bool get isNotEmpty => this != Lesson.empty;

  LessonEntity toEntity() {
    return LessonEntity(
      lessonId: id,
      lessonName: name,
      lessonImagePath: imagePath,
    );
  }

  /// Convert from LessonEntity to Lesson
  static Lesson fromEntity(LessonEntity entity) {
    return Lesson(
      id: entity.lessonId,
      name: entity.lessonName,
      imagePath: entity.lessonImagePath,
      description:
          '', // The description is not part of the entity, you may set a default value or handle this differently
    );
  }
}
