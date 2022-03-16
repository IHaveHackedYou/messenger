import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationService extends ChangeNotifier{

  // Firebase Authentication instance
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  // stream that passes user, whenever the auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // sign in user with email and password and return User in a future
  Future<User?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      notifyListeners();
      return null;//e.message ?? "firebase auth signInWithEmailAndPassword error";
    }
  }

  // sign up user with email and password and return User in a future
  Future<User?> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      notifyListeners();
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      notifyListeners();
      return null;
    }
  }
}
