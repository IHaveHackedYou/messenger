import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/enums.dart';
import 'package:messenger/src/_constants/widgets/error_message.dart';
import 'package:messenger/src/authentication/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, required this.signUp}) : super(key: key);
  
  // signUp callback for firebase function
  Future<User?> Function(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) signUp;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // bool _firebaseError = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: ((context) => SignUpProvider()),
        child: Consumer<SignUpProvider>(builder: (context, provider, child) {
          switch (provider.authState) {
            // show sign up forms
            case AuthenticationState.start:
              // TODO replace with Sign up forms
              return ElevatedButton(
                onPressed: () async {
                  // sign up function callback, with error message
                  widget.signUp("1234@gmail.com", "123456", ((e) {
                    provider.throwError();
                    errorMessage(context, "Firebase authentication", e);
                  })).then((value) {
                    // when future arrives, check on signUpProvider whether signUp was successful
                    provider.signUpFinished(context);
                  });
                  // when future hasn't arrived show loading circle
                  provider.startSignUpRequest();
                },
                child: const Text("SignUp"),
              );

            // show loading circle when waiting for firebase response
            case AuthenticationState.loading:
              return const Center(child: CircularProgressIndicator());

            default:
              return const Text("Internal error this shouldn't happen");
          }
        }));
  }
}
