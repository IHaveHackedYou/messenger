import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/enums.dart';
import 'package:messenger/src/_constants/widgets/error_message.dart';
import 'package:messenger/src/_constants/widgets/shaped_button.dart';
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
    final _formKey = GlobalKey<FormState>();
    TextEditingController _firstNameEditingController = TextEditingController();
    TextEditingController _lastNameEditingController = TextEditingController();
    TextEditingController _emailEditingController = TextEditingController();
    TextEditingController _passwordEditingController = TextEditingController();
    TextEditingController _confirmPasswordEditingController =
        TextEditingController();

    final _fistNameFormField = TextFormField(
      controller: _firstNameEditingController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      autofocus: false,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person_rounded),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your First Name";
        } else if (value.length > 10) {
          return "Your Name is too long";
        }
        return null;
      },
      onSaved: (value) {
        _firstNameEditingController.text = value!;
      },
    );
    final _lastNameFormField = TextFormField(
      controller: _lastNameEditingController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      autofocus: false,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person_rounded),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Last Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your Last Name";
        } else if (value.length > 10) {
          return "Your Name is too long";
        }
        return null;
      },
      onSaved: (value) {
        _lastNameEditingController.text = value!;
      },
    );

    final _emailFormField = TextFormField(
      controller: _emailEditingController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofocus: false,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_rounded),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Your Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your Email";
        } else if (!value.contains("@") && !value.contains(".")) {
          return "Enter a valid Email-Address";
        }
        return null;
      },
      onSaved: (value) {
        _emailEditingController.text = value!;
      },
    );

    final _passwordNameFormField = TextFormField(
      controller: _passwordEditingController,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key_rounded),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your Password";
        } else if (value.length < 8) {
          return "Your password is too short";
        }
        return null;
      },
      onSaved: (value) {
        _passwordEditingController.text = value!;
      },
    );

    final _confirmPasswordFormField = TextFormField(
      controller: _confirmPasswordEditingController,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.vpn_key_rounded),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please confirm your password";
        } else if (value != _passwordEditingController.text) {
          return "Your passwords don't match";
        }
        return null;
      },
      onSaved: (value) {
        _confirmPasswordEditingController.text = value!;
      },
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => SignUpProvider())),
      ],
      child: Consumer<SignUpProvider>(builder: (context, provider, child) {
        switch (provider.authState) {
          // show sign up forms
          case AuthenticationState.start:
            // TODO replace with Sign up forms
            return Form(
              key: _formKey,
              child: Material(
                child: Column(
                  children: [
                    _fistNameFormField,
                    const SizedBox(height: 20),
                    _lastNameFormField,
                    const SizedBox(height: 20),
                    _emailFormField,
                    const SizedBox(height: 20),
                    _passwordNameFormField,
                    const SizedBox(height: 20),
                    _confirmPasswordFormField,
                    const SizedBox(height: 20),
                    ShapedButton(
                      onPressFunction: () {
                        if (_formKey.currentState!.validate()) {
                          signUp(
                              _emailEditingController,
                              _passwordEditingController,
                              _firstNameEditingController,
                              provider);
                        }
                      },
                      title: "SignUp",
                    ),
                  ],
                ),
              ),
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

  void signUp(
      TextEditingController _emailEditingController,
      _passwordEditingController,
      _firstNameEditingController,
      SignUpProvider provider) {
    widget.authService.signUp(
        _emailEditingController.text,
        _passwordEditingController.text,
        _firstNameEditingController.text, ((e) {
      provider.throwError();
      errorMessage(context, "Firebase authentication", e);
    })).then((value) {
      // create custom user out of Firebase User
      CustomUser user = CustomUser(value!);
      print(user.user.uid);
      // FIXME doesn't work infinitly long loading
      DatabaseService databaseRef = DatabaseService(FirebaseFirestore.instance);
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
  }
}
