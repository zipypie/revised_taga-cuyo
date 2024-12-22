// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:taga_cuyo/src/features/services/authentication.dart'; // Import AuthService
// import 'package:taga_cuyo/src/features/screens/main_screens/home/home_screen.dart';
// import 'package:taga_cuyo/src/features/screens/onboarding_screens/login/email_verification.dart'; // Make sure this import is correct
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'error_handler.dart'; // Assuming you have a custom error handler

// class SignInCubit extends Cubit<bool> {
//   SignInCubit() : super(false); // false indicates not loading

//   final AuthService _authService = AuthService();

//   Future<Map<String, dynamic>?> getUserData(String uid) async {
//     try {
//       DocumentSnapshot snapshot =
//           await FirebaseFirestore.instance.collection('users').doc(uid).get();
//       return snapshot.exists ? snapshot.data() as Map<String, dynamic>? : null;
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<void> signInUser(BuildContext context, String email, String password) async {
//     if (email.isEmpty || password.isEmpty) {
//       ErrorHandler.handleError(context, 'missing_email');
//       return;
//     }

//     emit(true); // Start loading
//     try {
//       Map<String, dynamic> res =
//           await _authService.signInUser(email: email, password: password);

//       if (res['res'] == "Success" && res['uid'] != null) {
//         String uid = res['uid'];
//         Map<String, dynamic>? userData = await getUserData(uid);

//         if (userData != null) {
//           if (res['isEmailVerified']) {
//             // Navigate to HomeScreen
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => HomeScreen(uid: uid, userData: userData),
//               ),
//             );
//           } else {
//             // Show email verification dialog
//             showEmailVerificationDialog(context, email);
//           }
//         } else {
//           ErrorHandler.handleError(context, 'submission_error',
//               errorMessage: 'User data not found.');
//         }
//       } else {
//         ErrorHandler.handleError(context, 'submission_error',
//             errorMessage: 'Invalid credentials.');
//       }
//     } catch (e) {
//       ErrorHandler.handleError(context, 'submission_error',
//           errorMessage: e.toString());
//     } finally {
//       emit(false); // Stop loading
//     }
//   }
// }
