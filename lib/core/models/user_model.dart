// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String uid;
  String firstName;
  String lastName;
  User({
    required this.uid,
    required this.firstName,
    required this.lastName,
  });
  User copyWith({
    String? uid,
    String? firstName,
    String? lastName,
  }) {
    return User(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'User(uid: $uid, firstName: $firstName, lastName: $lastName)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode => uid.hashCode ^ firstName.hashCode ^ lastName.hashCode;
}
