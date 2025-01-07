import 'package:equatable/equatable.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/entities/entities.dart';

class MyUser extends Equatable {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String age;
  final String? gender;
  final String? profileImage;
  final String? motherTounge;
  final bool hasCompletedSurvey;
  final DateTime? createdAt;

  const MyUser({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
    this.gender,
    this.profileImage,
    this.motherTounge,
    this.hasCompletedSurvey = false,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        uid,
        firstName,
        lastName,
        email,
        age,
        gender,
        profileImage,
        motherTounge,
        hasCompletedSurvey,
        createdAt,
      ];

  static const empty = MyUser(
    uid: '',
    firstName: '',
    lastName: '',
    email: '',
    age: '',
    gender: null,
    profileImage: null,
    motherTounge: null,
    hasCompletedSurvey: false,
    createdAt: null,
  );

  MyUser copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    String? age,
    String? gender,
    String? profileImage,
    String? motherTounge,
    bool? hasCompletedSurvey,
    DateTime? createdAt,
  }) {
    return MyUser(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      profileImage: profileImage ?? this.profileImage,
      motherTounge: motherTounge ?? this.motherTounge,
      hasCompletedSurvey: hasCompletedSurvey ?? this.hasCompletedSurvey,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isEmpty => this == MyUser.empty;

  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity() {
    return MyUserEntity(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
      email: email,
      age: age,
      gender: gender,
      profileImage: profileImage,
      motherTounge: motherTounge,
      hasCompletedSurvey: hasCompletedSurvey,
      createdAt: createdAt?.toIso8601String(),
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      uid: entity.uid,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      age: entity.age,
      gender: entity.gender,
      profileImage: entity.profileImage,
      motherTounge: entity.motherTounge,
      hasCompletedSurvey: entity.hasCompletedSurvey,
      createdAt:
          entity.createdAt != null ? DateTime.parse(entity.createdAt!) : null,
    );
  }
}
