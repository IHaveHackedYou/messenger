import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/enums.dart';
import 'package:messenger/src/_constants/widgets/error_message.dart';

//! do not imper firebase.dart else your console is red

// belongs together with sign_up_screen.dart
class SignUpProvider extends ChangeNotifier {
  bool _errorOccurred = false;
  AuthenticationState _authState = AuthenticationState.start;

  AuthenticationState get authState => _authState;
  set authState(value) => _authState = _authState;

  // start signUp request to firebase and show loading while waiting on firebase response
  void startSignUpRequest() {
    _authState = AuthenticationState.loading;
    _errorOccurred = false;
    notifyListeners();
  }

  void resetSignUp() {
    _authState = AuthenticationState.start;
    notifyListeners();
  }

  void signUpFinished(BuildContext context, CustomUser user) {
    if (!_errorOccurred) {
      // TODO use CustomUser
      // go to homepage if signUp was successful
      Navigator.of(context).pushReplacementNamed("/homePage");
    } else {
      // if an error occurred during signUp procedure reset signUp
      resetSignUp();
    }
    notifyListeners();
  }

  void throwError() {
    _errorOccurred = true;
    resetSignUp();
  }
}
