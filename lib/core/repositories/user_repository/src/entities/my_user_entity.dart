// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

// Entity for data storage (e.g., Firestore)
class MyUserEntity extends Equatable {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String age;
  final String? gender;
  final String? profileImage;
  final String? motherTounge;
  final bool hasCompletedSurvey;
  final String? createdAt;

  const MyUserEntity({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.age,
    this.gender,
    this.profileImage,
    this.motherTounge,
    required this.hasCompletedSurvey,
    this.createdAt,
  });

  /// Copy Method
  MyUserEntity copyWith({
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    String? age,
    String? gender,
    String? profileImage,
    String? motherTounge,
    bool? hasCompletedSurvey,
    String? createdAt,
  }) {
    return MyUserEntity(
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

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
      'gender': gender,
      'profileImage': profileImage,
      'motherTounge': motherTounge,
      'hasCompletedSurvey': hasCompletedSurvey,
      'createdAt': createdAt,
    };
  }

  /// Create from Map
  factory MyUserEntity.fromMap(Map<String, dynamic> map) {
    return MyUserEntity(
      uid: map['uid'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      age: map['age'] as String,
      gender: map['gender'] as String?,
      profileImage: map['profileImage'] as String?,
      motherTounge: map['motherTounge'] as String?,
      hasCompletedSurvey: map['hasCompletedSurvey'] as bool,
      createdAt: map['createdAt'] as String?,
    );
  }

  /// Convert to JSON
  String toJson() => json.encode(toMap());

  /// Create from JSON
  factory MyUserEntity.fromJson(String source) =>
      MyUserEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

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
}
