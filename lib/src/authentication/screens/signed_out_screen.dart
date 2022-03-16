import 'package:flutter/material.dart';

class SignedOutScreen extends StatelessWidget {
  const SignedOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Home Screen
          ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed("/homePage"),
              child: Text("homePage")),
          // Sign in
          ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/signIn"),
              child: Text("SignIn")),
          // Sign up
          ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed("/signUp"),
              child: Text("SignUp"))
        ],
      ),
    ));
  }
}
