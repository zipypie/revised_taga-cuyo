// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SignUpService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // Sign up a new user
//   Future<User> signUpUser({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String password,
//     required int age,
//     required String gender,
//     String? profileImage,
//   }) async {
//     try {
//       // Create a user with email and password
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       String uid = credential.user!.uid;

//       // Store user details in Firestore
//       await _firestore.collection('users').doc(uid).set({
//         'firstname': firstName,
//         'lastname': lastName,
//         'email': email,
//         'age': age,
//         'gender': gender,
//         'uid': uid,
//         'date_joined': DateTime.now(),
//         'profile_image': profileImage ?? '',
//         'hasCompletedSurvey': false,
//         'status': 'offline',
//         'lastSeen': FieldValue.serverTimestamp(),
//       });

//       // Add user progress details
//       await _firestore.collection('user_progress').doc(uid).set({
//         'categories': 0,
//         'days': 0,
//         'lessons': 0,
//         'minutes': 0,
//         'streak': 0,
//         'longest_streak': 0,
//       });

//       // Create and return the User object
//       return User(
//         uid: uid,
//         firstName: firstName,
//         lastName: lastName,
//         email: email,
//         gender: gender,
//         age: age,
//         profileImage: profileImage,
//       );
//     } catch (e) {
//       rethrow; // Throw the error for handling in the calling function
//     }
//   }
// }
