import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserProgress extends Equatable {
  final int lessons;
  final int category;
  final int days;
  final int minutes;
  final int longestStreak;

  const UserProgress({
    required this.lessons,
    required this.category,
    required this.days,
    required this.minutes,
    required this.longestStreak,
  });

  @override
  List<Object?> get props => [
        lessons,
        category,
        days,
        minutes,
        longestStreak,
      ];

  /// Empty UserProgress Constant
  static const empty = UserProgress(
    lessons: 0,
    category: 0,
    days: 0,
    minutes: 0,
    longestStreak: 0,
  );

  /// Copy Method
  UserProgress copyWith({
    int? lessons,
    int? category,
    int? days,
    int? minutes,
    int? longestStreak,
  }) {
    return UserProgress(
      lessons: lessons ?? this.lessons,
      category: category ?? this.category,
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
      'category': category,
      'days': days,
      'minutes': minutes,
      'longestStreak': longestStreak,
    };
  }

  /// Create from Map
  static UserProgress fromMap(Map<String, dynamic> map) {
    return UserProgress(
      lessons: map['lessons'] as int,
      category: map['category'] as int,
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
