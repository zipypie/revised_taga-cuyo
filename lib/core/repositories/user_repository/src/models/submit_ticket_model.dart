import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../user_repository.dart';

class SubmitTicketModel extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String issue;
  final String? imageIssue;
  final String timeStamp;
  final String deviceInfo;

  const SubmitTicketModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.issue,
    this.imageIssue,
    required this.timeStamp,
    required this.deviceInfo,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        issue,
        imageIssue,
        timeStamp,
        deviceInfo,
      ];

  static const empty = SubmitTicketModel(
    firstName: '',
    lastName: '',
    email: '',
    issue: '',
    imageIssue: null,
    timeStamp: '',
    deviceInfo: '',
  );

  SubmitTicketModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? issue,
    String? imageIssue,
    String? timeStamp,
    String? deviceInfo,
  }) {
    return SubmitTicketModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      issue: issue ?? this.issue,
      imageIssue: imageIssue ?? this.imageIssue,
      timeStamp: timeStamp ?? this.timeStamp,
      deviceInfo: deviceInfo ?? this.deviceInfo,
    );
  }

  bool get isEmpty => this == SubmitTicketModel.empty;

  bool get isNotEmpty => this != SubmitTicketModel.empty;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'issue': issue,
      'imageIssue': imageIssue,
      'timeStamp': timeStamp,
      'deviceInfo': deviceInfo,
    };
  }

  factory SubmitTicketModel.fromMap(Map<String, dynamic> map) {
    return SubmitTicketModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      issue: map['issue'] as String,
      imageIssue: map['imageIssue'] as String?,
      timeStamp: map['timeStamp'] as String,
      deviceInfo: map['deviceInfo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubmitTicketModel.fromJson(String source) =>
      SubmitTicketModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // Factory method to create SubmitTicketModel from MyUser
  factory SubmitTicketModel.fromUserAndIssue(MyUser user, String issue,
      String timeStamp, String deviceInfo, String? imageIssue) {
    return SubmitTicketModel(
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      issue: issue,
      imageIssue: imageIssue,
      timeStamp: timeStamp,
      deviceInfo: deviceInfo,
    );
  }
}
