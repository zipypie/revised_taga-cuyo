import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserProgress {
  int lessons;
  int category;
  int days;
  UserProgress({
    required this.lessons,
    required this.category,
    required this.days,
  });

  UserProgress copyWith({
    int? lessons,
    int? category,
    int? days,
  }) {
    return UserProgress(
      lessons: lessons ?? this.lessons,
      category: category ?? this.category,
      days: days ?? this.days,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lessons': lessons,
      'category': category,
      'days': days,
    };
  }

  factory UserProgress.fromMap(Map<String, dynamic> map) {
    return UserProgress(
      lessons: map['lessons'] as int,
      category: map['category'] as int,
      days: map['days'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProgress.fromJson(String source) =>
      UserProgress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserProgress(lessons: $lessons, category: $category, days: $days)';

  @override
  bool operator ==(covariant UserProgress other) {
    if (identical(this, other)) return true;

    return other.lessons == lessons &&
        other.category == category &&
        other.days == days;
  }

  @override
  int get hashCode => lessons.hashCode ^ category.hashCode ^ days.hashCode;
}
