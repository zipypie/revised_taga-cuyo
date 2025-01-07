import 'dart:convert';
import 'package:equatable/equatable.dart';

class UserProgressEntity extends Equatable {
  final int lessons;
  final int category;
  final int days;
  final int minutes;
  final int longestStreak;

  const UserProgressEntity({
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

  /// Copy Method
  UserProgressEntity copyWith({
    int? lessons,
    int? category,
    int? days,
    int? minutes,
    int? longestStreak,
  }) {
    return UserProgressEntity(
      lessons: lessons ?? this.lessons,
      category: category ?? this.category,
      days: days ?? this.days,
      minutes: minutes ?? this.minutes,
      longestStreak: longestStreak ?? this.longestStreak,
    );
  }

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
  factory UserProgressEntity.fromMap(Map<String, dynamic> map) {
    return UserProgressEntity(
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
  factory UserProgressEntity.fromJson(String source) {
    return UserProgressEntity.fromMap(
        json.decode(source) as Map<String, dynamic>);
  }
}
