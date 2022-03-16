import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customfirebase/customfirebase.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    // Provider of Firebase auth class
    return ChangeNotifierProvider(create: (context) => AuthenticationService(FirebaseAuth.instance),
    child: Consumer<AuthenticationService>(builder: (context, value, child) {
      return ElevatedButton(
          onPressed: () async {
            final authProvider = Provider.of<AuthenticationService>(context, listen: false);
            // TODO implement logic, function to call to sign up user, signUp/signIn returns firebase User in a future
            // TODO implement Future validation and User readout
            //! Password must be longer than 6 char else there are firebase auth errors
            User? user = await authProvider.signUp("1234567@gmail.com", "123456");
          }, child: Text("SignUp"),

        );
    }));
  }
}
