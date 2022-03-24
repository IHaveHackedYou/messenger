//* Behavior is finished in sign_up_screen.dart
import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/enums.dart';
import 'package:messenger/src/_constants/widgets/error_message.dart';
import 'package:messenger/src/authentication/provider/sign_in_provider.dart';
import 'package:messenger/src/authentication/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key, required this.authService}) : super(key: key);

  // auth service ref to access signUp
  AuthenticationService authService;
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _emailEditingController = TextEditingController();
    TextEditingController _passwordEditingController = TextEditingController();

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => SignInProvider())),
      ],
      child: Consumer<SignInProvider>(builder: (context, provider, child) {
        switch (provider.authState) {
          // show sign up forms
          case AuthenticationState.start:
            // TODO replace with Sign up forms
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Sign in",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              body: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _emailFormField,
                        const SizedBox(height: 20),
                        _passwordNameFormField,
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              signIn(_emailEditingController,
                                  _passwordEditingController, provider);
                            }
                          },
                          child: const Text("SignUp"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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

  void signIn(TextEditingController _emailEditingController,
      _passwordEditingController, SignInProvider provider) async {
    //* start sign up request
    widget.authService.signIn(
      _emailEditingController.text,
      _passwordEditingController.text,
      ((e) {
        provider.throwError();
        errorMessage(context, "Firebase authentication", e);
      }),
    )

        //* sign up request succeeded

        //* addUser request was successful
        .then(
      (value) {
        CustomUser user = CustomUser(value!);
        // finish sign up and transfer to homescreen
        provider.signInFinished(context, user);
      },
    );

    // when future hasn't arrived show loading circle
    provider.startSignInRequest();
  }
}
