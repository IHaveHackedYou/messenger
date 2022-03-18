import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/widgets/error_message.dart';
import 'package:messenger/src/authentication/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, required this.signUp}) : super(key: key);
  Future<User?> Function(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) signUp;
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _firebaseError = false;
  @override
  Widget build(BuildContext context) {
    //TODO use sign_up_provider class
    return ChangeNotifierProvider(
      create: ((context) => SignUpProvider()),
      child: Consumer<SignUpProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              provider.waitingOnSignUp
                  ? Text("loading")
                  // FutureBuilder(
                  //     builder: ((context, snapshot) {
                  //       if (snapshot.hasData) {
                  //         User user = snapshot.data as User;
                  //         return Text(user.uid);
                  //       } else if (snapshot.hasError || _firebaseError) {
                  //         provider.finishedSignUpRequest();
                  //         return Text("error");
                  //       }
                  //       return Text("loading");
                  //     }),
                  //     future: widget.signUp("1234@gmail.com", "123456", ((e) {
                  //       _firebaseError = true;
                  //       errorMessage(context, "Firebase authentication", e);
                  //     })),
                  //   )
                  : ElevatedButton(
                      onPressed: () async {
                        // TODO implement logic, function to call to sign up user, signUp/signIn returns firebase User in a future
                        // TODO implement Future validation and User readout
                        //! Password must be longer than 6 char else there are firebase auth errors
                        //User? user = await widget.signUp("123@gmail.com", "123456",
                        //  ((e) => errorMessage(context, "Firebase authentication", e)));
                        _firebaseError = false;
                        widget.signUp("1234@gmail.com", "123456", ((e) {
                          _firebaseError = true;
                          provider.finishedSignUpRequest();
                          errorMessage(context, "Firebase authentication", e);
                        }));
                        // .then((value) {
                        //   if (!_firebaseError) {
                        //     Navigator.of(context)
                        //         .pushReplacementNamed("/homepage");
                        //   }
                        //   provider.startSignUpRequest();
                        // });
                      },
                      child: Text("SignUp"),
                    )
            ],
          );
        },
      ),
    );
  }
}
