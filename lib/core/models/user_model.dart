class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final int age;
  final String? profileImage;

  User({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.age,
    this.profileImage,
  });

  // Factory constructor for Firestore data
  factory User.fromFirestore(String uid, Map<String, dynamic> data) {
    return User(
      uid: uid,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      gender: data['gender'] ?? '',
      age: data['age'] ?? 0,
      profileImage: data['profileImage'],
    );
  }

  // Firestore-compatible map
  Map<String, dynamic> toFirestore() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'age': age,
      'profileImage': profileImage,
    };
  }
}
