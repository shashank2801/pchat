import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  // Future<String> signIn({String email,String password}) async{
  //   try {
  //     await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  //     return "Signed In";

  //   } on FirebaseAuthException catch(e) {
  //     return e.message;
  //   }
  // }

    Future signIn({String email,String password}) async{
    try {
     await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
           // FirebaseUser user = result.user;
      
      return "Signed In";

    } on FirebaseAuthException catch(e) {
      if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
    }
  }
    }

  Future<String> signUp({String email,String password}) async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed Up";
    }
     on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
    return('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    return('The account already exists for that email.');
  }
    }
  
  }
    }
    