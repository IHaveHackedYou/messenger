import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

// only provider manager, everything else handles SignOutScreen below
class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      // general provider for AuthenticationService class
      Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance)),
      // listens for User changes
      StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null)
    ], child: SignOutScreen());
  }
}

class SignOutScreen extends StatelessWidget {
  const SignOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.watch<User?>();
    //TODO remove when finished
    if (_firebaseUser != null) {
      Navigator.of(context).pushReplacementNamed("/homePage");
    }
    return Scaffold(
      body: Column(
        children: [
          // Sign up button
          ElevatedButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed(
                  "/signUp",
                  arguments: context.read<AuthenticationService>().signIn),
              child: Text("SignUp")),
          // Sign in button
          ElevatedButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed(
                  "/signIn",
                  arguments: context.read<AuthenticationService>().signIn),
              child: Text("SignIn")),
        ],
      ),
    );
  }
}
