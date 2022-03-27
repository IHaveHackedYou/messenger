import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/enums.dart';

//! IMPORTANT
//!
//! do not import firebase.dart else your console is red
//!
//! IMPORTANT

// belongs together with sign_up_screen.dart
class SignInProvider extends ChangeNotifier {
  bool _errorOccurred = false;
  AuthenticationState _authState = AuthenticationState.start;

  AuthenticationState get authState => _authState;
  set authState(value) => _authState = _authState;

  // start signUp request to firebase and show loading while waiting on firebase response
  void startSignInRequest() {
    _authState = AuthenticationState.loading;
    _errorOccurred = false;
    notifyListeners();
  }

  // go to signUp screen again, e.g. when an error occurred
  void resetSignIn() {
    _authState = AuthenticationState.start;
    notifyListeners();
  }

  // validate signUp finish
  void signInFinished(BuildContext context, CustomUser user) {
    if (!_errorOccurred) {
      // TODO use CustomUser
      // go to homepage if signUp was successful
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/homePage", (Route<dynamic> route) => false,
          arguments: user);
    } else {
      // if an error occurred during signUp procedure reset signUp
      resetSignIn();
    }
    notifyListeners();
  }

  void throwError() {
    _errorOccurred = true;
    resetSignIn();
  }
}

//! IMPORTANT
//!
//! do not import firebase.dart else your console is red
//!
//! IMPORTANT
