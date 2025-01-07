// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// Entity for data storage (e.g., Firestore)
// MyUserEntity Class for Data Storage (Firestore)
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

  factory MyUserEntity.fromMap(Map<String, dynamic> map) {
    return MyUserEntity(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? '',
      gender: map['gender'] as String?,
      profileImage: map['profileImage'] as String?,
      motherTounge: map['motherTounge'] as String?,
      hasCompletedSurvey: map['hasCompletedSurvey'] ?? false,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] is Timestamp
              ? (map['createdAt'] as Timestamp).toDate().toIso8601String()
              : map['createdAt']) // Handle Timestamp or String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

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
