import 'dart:convert';
import 'package:equatable/equatable.dart';

class UserProgressEntity extends Equatable {
  final int lessons;
  final int categories;
  final int days;
  final int minutes;
  final int longestStreak;

  const UserProgressEntity({
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

  /// Copy Method
  UserProgressEntity copyWith({
    int? lessons,
    int? categories,
    int? days,
    int? minutes,
    int? longestStreak,
  }) {
    return UserProgressEntity(
      lessons: lessons ?? this.lessons,
      categories: categories ?? this.categories,
      days: days ?? this.days,
      minutes: minutes ?? this.minutes,
      longestStreak: longestStreak ?? this.longestStreak,
    );
  }

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
  factory UserProgressEntity.fromMap(Map<String, dynamic> map) {
    return UserProgressEntity(
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
  factory UserProgressEntity.fromJson(String source) {
    return UserProgressEntity.fromMap(
        json.decode(source) as Map<String, dynamic>);
  }
}
