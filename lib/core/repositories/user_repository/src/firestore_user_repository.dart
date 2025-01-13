import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:taga_cuyo/core/models/device_info.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/entities/entities.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/models/feedback_model.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/models/my_user.dart';
import 'package:taga_cuyo/core/repositories/user_repository/src/models/submit_ticket_model.dart';
import 'user_repo.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  final usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser;
      return user;
    });
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser = myUser.copyWith(uid: user.user!.uid);

      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await usersCollection.doc(user.uid).set(user.toEntity().toMap());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> getMyUser(String myUserId) async {
    try {
      final doc = await usersCollection.doc(myUserId).get();
      log('Fetching user with ID: $myUserId');
      if (!doc.exists) {
        log('User document not found');
        throw Exception('User not found');
      }
      log('User document data: ${doc.data()}');
      return MyUser.fromEntity(MyUserEntity.fromMap(doc.data()!));
    } catch (e) {
      log('Error fetching user: $e');
      rethrow;
    }
  }

  @override
  Future<bool> isEmailVerified() async {
    User? user = _firebaseAuth.currentUser;
    return user?.emailVerified ?? false;
  }

  @override
  Future<void> sendVerificationEmail() async {
    User? user = _firebaseAuth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  @override
  String? getCurrentUserId() {
    return _firebaseAuth.currentUser?.uid;
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> uploadPicture(String file, String userId) async {
    try {
      File imageFile = File(file);
      Reference firebaseStoreRef = FirebaseStorage.instance.ref().child(
          'user_storage/$userId/profile_picture/${userId}_profile_picture');
      await firebaseStoreRef.putFile(
        imageFile,
      );
      String url = await firebaseStoreRef.getDownloadURL();
      await usersCollection.doc(userId).update({'profileImage': url});
      return url;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addTicketToFirestore(
      SubmitTicketModel ticket, MyUser user) async {
    final ticketsCollection = FirebaseFirestore.instance.collection('tickets');
    try {
      // Get device details from DeviceInfoService
      final deviceDetails = await DeviceInfoService().getDeviceDetails();

      // Add the ticket data to Firestore
      await ticketsCollection.add({
        'fullName': '${user.firstName} ${user.lastName}',
        'email': user.email,
        'subject': ticket.subject,
        'issue': ticket.issue,
        'imageIssue': ticket.imageIssue ?? '',
        'timeStamp': ticket.timeStamp,
        'deviceInfo': deviceDetails,
      });
    } catch (e) {
      log("Error adding ticket to Firestore: $e");
    }
  }

  @override
  Future<void> addFeedbackToFirestore(
      FeedbackModel feedback, MyUser user) async {
    final feedbackCollection =
        FirebaseFirestore.instance.collection('feedback');
    try {
      // Get device details from DeviceInfoService (optional)
      final deviceDetails = await DeviceInfoService().getDeviceDetails();

      // Add the feedback data to Firestore
      await feedbackCollection.add({
        'rating': feedback.rating,
        'selectedOptions': feedback.selectedOptions,
        'comments': feedback.comments,
        'timestamp': feedback.timestamp,
        'userFullName': '${user.firstName} ${user.lastName}',
        'userEmail': user.email,
        'deviceInfo': deviceDetails,
        'uid': user.uid
      });
    } catch (e) {
      log("Error adding feedback to Firestore: $e");
    }
  }
}
