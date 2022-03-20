import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{

  // Firebase Authentication instance
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  // stream that passes user, whenever the auth state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // sign in user with email and password and return User in a future
  Future<User?> signIn(String email, String password, void Function(FirebaseAuthException e) errorCallback,) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
      return null;
    }
  }

  // sign up user with email and password and return User in a future
  Future<User?> signUp(String email, String password, String displayName,void Function(FirebaseAuthException e) errorCallback,) async {
    try {
      // create user only with email and pw
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      
      // get current user
      User? user = _firebaseAuth.currentUser;
      
      // if user is valid set/update display name and reload to apply
      if(user != null){
        await _firebaseAuth.currentUser!.updateDisplayName(displayName);
        await _firebaseAuth.currentUser!.reload();
      }
      
      // return current user
      return _firebaseAuth.currentUser;
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
      return null;
    }
  }

  Future<void> signOut(void Function(FirebaseAuthException e) errorCallback,) async{
    try{
      await _firebaseAuth.signOut();
    }on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

}
