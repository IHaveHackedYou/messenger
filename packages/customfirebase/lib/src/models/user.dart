import 'package:firebase_auth/firebase_auth.dart';

class CustomUser{
  // firebase user
  User _user;
  // e.g. profile picture

  User get user => _user;
  CustomUser(this._user);

  // convert to map for saving
  Map<String, dynamic> toMap(){
    return {
      "email" : _user.email,
      "name" : _user.displayName,
      "uid" : _user.uid
    };
  }
}