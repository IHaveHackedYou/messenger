import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/enums.dart';

class SignUpProvider extends ChangeNotifier {
  bool _waitingOnSignUp = false;
  bool _errorOccurred = false;
  AuthenticationState _authState = AuthenticationState.start;

  bool get waitingOnSignUp => _waitingOnSignUp;

  AuthenticationState get authState => _authState;
  set authState(value) => _authState = _authState;

  void startSignUpRequest() {
    _authState = AuthenticationState.loading;
    _errorOccurred = false;
    notifyListeners();
  }

  void resetSignUp() {
    _authState = AuthenticationState.start;
    notifyListeners();
  }

  void signUpFinished(BuildContext context) {
    if (!_errorOccurred)
      Navigator.of(context).pushReplacementNamed("/homePage");
    else
      resetSignUp();
    notifyListeners();
  }

  void throwError() {
    _errorOccurred = true;
  }
}
