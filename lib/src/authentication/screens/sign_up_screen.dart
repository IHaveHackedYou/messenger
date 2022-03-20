import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/enums.dart';
import 'package:messenger/src/_constants/widgets/error_message.dart';
import 'package:messenger/src/authentication/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, required this.authService}) : super(key: key);

  // auth service ref to access signUp
  AuthenticationService authService;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => SignUpProvider())),
      ],
      child: Consumer<SignUpProvider>(builder: (context, provider, child) {
        switch (provider.authState) {
          // show sign up forms
          case AuthenticationState.start:
            // TODO replace with Sign up forms
            return ElevatedButton(
              onPressed: () async {
                //* start sign up request
                widget.authService
                    .signUp("12345678911111@gmail.com", "123456", "Hans", ((e) {
                  provider.throwError();
                  errorMessage(context, "Firebase authentication", e);
                }))

                    //* sign up request succeeded
                    .then((value) {
                  // create custom user out of Firebase User
                  CustomUser user = CustomUser(value!);

                  // initialize database service
                  DatabaseService databaseRef =
                      DatabaseService(FirebaseFirestore.instance);

                  //* start addUser request
                  databaseRef.addUser(user, ((e) {
                    provider.throwError();
                    errorMessage(context, "Firestore user adding", e);
                  }))

                      //* addUser request was successful
                      .then(
                    (value) {
                      // finish sign up and transfer to homescreen
                      provider.signUpFinished(context, user);
                    },
                  );
                });
                // when future hasn't arrived show loading circle
                provider.startSignUpRequest();
              },
              child: const Text("SignUp"),
            );

          // show loading circle when waiting for firebase response
          case AuthenticationState.loading:
            // TODO add loading screen
            return const Center(child: CircularProgressIndicator());

          default:
            return const Text("Internal error this shouldn't happen");
        }
      }),
    );
  }
}
