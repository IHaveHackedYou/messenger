import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.all(20),
          child: MultiProvider(
              providers: [
                Provider<AuthenticationService>(
                    create: (_) =>
                        AuthenticationService(FirebaseAuth.instance)),
                StreamProvider(
                    create: (context) =>
                        context.read<AuthenticationService>().authStateChanges,
                    initialData: null)
              ],
              // child: Column(
              //   children: [
              //     // Home Screen
              //     ElevatedButton(
              //         onPressed: () =>
              //             Navigator.of(context).pushReplacementNamed("/homePage"),
              //         child: Text("homePage")),
              //     // Sign in
              //     ElevatedButton(
              //         onPressed: () => Navigator.of(context).pushNamed("/signIn"),
              //         child: Text("SignIn")),
              //     // Sign up
              //     ElevatedButton(
              //         onPressed: () => Navigator.of(context).pushNamed("/signUp"),
              //         child: Text("SignUp"))
              //   ],
              // ),
              child: SignOutScreen())),
    );
  }
}

class SignOutScreen extends StatelessWidget {
  const SignOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.watch<User?>();
    //TODO remove when finished and add homepage in curly braces
    // if (_firebaseUser != null) {
    //   return Text(_firebaseUser.uid);
    // }
    return Container(
      child: ElevatedButton(
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed("/signUp", arguments: context.read<AuthenticationService>().signUp),
          child: Text("homePage")),
    );
  }
}
