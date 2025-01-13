import 'package:equatable/equatable.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/entities/entities.dart';

class UserProgress extends Equatable {
  final int lessons;
  final int categories;
  final int days;
  final int minutes;
  final int longestStreak;

  const UserProgress({
    required this.lessons,
    required this.categories,
    required this.days,
    required this.minutes,
    required this.longestStreak,
  });

  @override
  List<Object?> get props => [
        lessons,
        categories,
        days,
        minutes,
        longestStreak,
      ];

  static const empty = UserProgress(
    lessons: 0,
    categories: 0,
    days: 0,
    minutes: 0,
    longestStreak: 0,
  );

  UserProgress copyWith({
    int? lessons,
    int? categories,
    int? days,
    int? minutes,
    int? longestStreak,
  }) {
    return UserProgress(
      lessons: lessons ?? this.lessons,
      categories: categories ?? this.categories,
      days: days ?? this.days,
      minutes: minutes ?? this.minutes,
      longestStreak: longestStreak ?? this.longestStreak,
    );
  }

  bool get isEmpty => this == UserProgress.empty;

  bool get isNotEmpty => this != UserProgress.empty;

  UserProgressEntity toEntity() {
    return UserProgressEntity(
      lessons: lessons,
      categories: categories,
      days: days,
      minutes: minutes,
      longestStreak: longestStreak,
    );
  }

  static UserProgress fromEntity(UserProgressEntity entity) {
    return UserProgress(
      lessons: entity.lessons,
      categories: entity.categories,
      days: entity.days,
      minutes: entity.minutes,
      longestStreak: entity.longestStreak,
    );
  }
}
