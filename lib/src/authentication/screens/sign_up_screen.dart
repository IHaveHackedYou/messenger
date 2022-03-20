import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/enums.dart';
import 'package:messenger/src/_constants/widgets/error_message.dart';
import 'package:messenger/src/authentication/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, required this.authService}) : super(key: key);

  // signUp callback for firebase function
  /* Future<User?> Function(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) signUp; 
  Stream<User?> Function() authStateChanges;*/
  AuthenticationService authService;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // bool _firebaseError = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(
          create: ((context) => SignUpProvider())),
          ],
      child: Consumer<SignUpProvider>(builder: (context, provider, child) {
        switch (provider.authState) {
          // show sign up forms
          case AuthenticationState.start:
            // TODO replace with Sign up forms
            return ElevatedButton(
              onPressed: () async {
                // sign up function callback, with error message
                widget.authService
                    .signUp("12345678911111@gmail.com", "123456", "Hans", ((e) {
                  provider.throwError();
                  errorMessage(context, "Firebase authentication", e);
                })).then((value) {
                   // create custom user out of Firebase User
                  CustomUser user = CustomUser(value!);
                  print(user.user.uid);
                  // FIXME doesn't work infinitly long loading
                  DatabaseService databaseRef =
                       DatabaseService(FirebaseFirestore.instance);
                  databaseRef.addUser(user, ((e) {
                    provider.throwError();
                    errorMessage(context, "Firestore user adding", e);
                  })).then(
                    (value) {
                      print("finished");
                      provider.signUpFinished(context, user);
                    },
                  ); 
                  provider.signUpFinished(context, user);
                  // when future arrives, check on signUpProvider whether signUp was successful
                  // and pass context and user in
                  // provider.signUpFinished(context, user);
                });
                // when future hasn't arrived show loading circle
                provider.startSignUpRequest();
              },
              child: const Text("SignUp"),
            );
    
          // show loading circle when waiting for firebase response
          case AuthenticationState.loading:
            return Center(child: CircularProgressIndicator());
    
          default:
            return const Text("Internal error this shouldn't happen");
        }
      }),
    );
  }
}
