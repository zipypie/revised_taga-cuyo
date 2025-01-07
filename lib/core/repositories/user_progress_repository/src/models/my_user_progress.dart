import 'dart:convert';

import 'package:equatable/equatable.dart';

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

  /// Empty UserProgress Constant
  static const empty = UserProgress(
    lessons: 0,
    categories: 0,
    days: 0,
    minutes: 0,
    longestStreak: 0,
  );

  /// Copy Method
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

  /// Check if UserProgress is Empty
  bool get isEmpty => this == UserProgress.empty;

  /// Check if UserProgress is Not Empty
  bool get isNotEmpty => this != UserProgress.empty;

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'lessons': lessons,
      'categories': categories,
      'days': days,
      'minutes': minutes,
      'longestStreak': longestStreak,
    };
  }

  /// Create from Map
  static UserProgress fromMap(Map<String, dynamic> map) {
    return UserProgress(
      lessons: map['lessons'] as int,
      categories: map['categories'] as int,
      days: map['days'] as int,
      minutes: map['minutes'] as int,
      longestStreak: map['longestStreak'] as int,
    );
  }

  /// Convert to JSON
  String toJson() => json.encode(toMap());

  /// Create from JSON
  static UserProgress fromJson(String source) {
    return UserProgress.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
