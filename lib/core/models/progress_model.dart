import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserProgress {
  int lessons;
  int category;
  int days;
  int minutes;
  int longestStreak;
  UserProgress({
    required this.lessons,
    required this.category,
    required this.days,
    required this.minutes,
    required this.longestStreak,
  });

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lessons': lessons,
      'category': category,
      'days': days,
      'minutes': minutes,
      'longestStreak': longestStreak,
    };
  }

  factory UserProgress.fromMap(Map<String, dynamic> map) {
    return UserProgress(
      lessons: map['lessons'] as int,
      category: map['category'] as int,
      days: map['days'] as int,
      minutes: map['minutes'] as int,
      longestStreak: map['longestStreak'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProgress.fromJson(String source) =>
      UserProgress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProgress(lessons: $lessons, category: $category, days: $days, minutes: $minutes, longestStreak: $longestStreak)';
  }

  @override
  bool operator ==(covariant UserProgress other) {
    if (identical(this, other)) return true;

    return other.lessons == lessons &&
        other.category == category &&
        other.days == days &&
        other.minutes == minutes &&
        other.longestStreak == longestStreak;
  }

  @override
  int get hashCode {
    return lessons.hashCode ^
        category.hashCode ^
        days.hashCode ^
        minutes.hashCode ^
        longestStreak.hashCode;
  }
}
