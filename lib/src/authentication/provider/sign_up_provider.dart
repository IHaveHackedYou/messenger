import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier{
  bool _waitingOnSignUp = false;

  bool get waitingOnSignUp => _waitingOnSignUp;

  void startSignUpRequest(){
    _waitingOnSignUp = true;
    notifyListeners();
  }

  void finishedSignUpRequest(){
    _waitingOnSignUp = false;
    notifyListeners();
  }

}