import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pchat/userModel.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();
  UserModel userModel = UserModel();
  final userRef = FirebaseFirestore.instance.collection("users");

  AuthenticationService(this._firebaseAuth);

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      // FirebaseUser user = result.user;

      return "Signed In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      }
    }
  }

  Future signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    }
  }

  Future<void> addUserToDB(
      {String uid, String username, String email, DateTime timestamp}) async {
    userModel = UserModel(
        uid: uid, username: username, email: email, timestamp: timestamp);
  
    await userRef.add(userModel.toMap(userModel));
  }

  Future<UserModel> getUserFromDB({String uid}) async {
    final DocumentSnapshot doc = await userRef.doc(uid).get();
      return UserModel.fromMap(doc.data());
  }
}
