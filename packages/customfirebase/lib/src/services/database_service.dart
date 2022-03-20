import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customfirebase/src/models/chat.dart';
import 'package:customfirebase/src/models/user.dart';

import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  List<Chat> chats = List.empty(growable: true);
  late CollectionReference _users;
  final FirebaseFirestore _firestoreInstance;

  DatabaseService(this._firestoreInstance) {
    _users = _firestoreInstance.collection("users");
  }

  // add user to public user list, should be added when user gets signed in
  Future<void> addUser(
    CustomUser user,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    //* file structure /users/'uid'/{name: 'name', ...}
    return _users
        .doc(user.user.uid)
        .set(user.toMap())
        .then((value) => print("user added"))
        .catchError((e) {
      errorCallback(e);
    });
  }
}
