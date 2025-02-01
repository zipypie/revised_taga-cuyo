import 'package:firebase_auth/firebase_auth.dart';
import '../user_repository.dart';
import 'models/feedback_model.dart';
import 'models/submit_ticket_model.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<MyUser> signUp(MyUser myUser, String password);

  Future<void> signIn(String email, String password);

  Future<void> logOut();

  Future<void> resetPassword(String email);

  Future<void> setUserData(MyUser user);

  Future<MyUser> getMyUser(String myUserId);

  // Add method to check if email is verified
  Future<bool> isEmailVerified();

  // Add method to send verification email
  Future<void> sendVerificationEmail();

  String? getCurrentUserId();

  Future<void> updatePassword(String newPassword);

  Future<String> uploadPicture(String file, String userId);

  Future<void> addTicketToFirestore(SubmitTicketModel ticket, MyUser user);

  Future<void> addFeedbackToFirestore(FeedbackModel feedback, MyUser user);
}
