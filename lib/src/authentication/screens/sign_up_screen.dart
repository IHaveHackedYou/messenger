import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/enums.dart';
import 'package:messenger/src/_constants/widgets/error_message.dart';
import 'package:messenger/src/_constants/widgets/input_field.dart';
import 'package:messenger/src/_constants/widgets/shaped_button.dart';
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
    final _formKey = GlobalKey<FormState>();
    TextEditingController _firstNameEditingController = TextEditingController();
    TextEditingController _emailEditingController = TextEditingController();
    TextEditingController _passwordEditingController = TextEditingController();
    TextEditingController _confirmPasswordEditingController =
        TextEditingController();

    //ScrollController _controller = ScrollController();

    final _fistNameFormField = InputField(
      textEditingController: _firstNameEditingController,
      inputType: TextInputType.name,
      icon: const Icon(Icons.person_rounded),
      hint: "Name",
      validatorFunction: (value) {
        if (value!.isEmpty) {
          return "Please enter your First Name";
        } else if (value.length > 10) {
          return "Your Name is too long";
        }
        return null;
      },
      //onTap: () => _controller.jumpTo(_controller.position.maxScrollExtent),
      onSavedFunction: (value) => _firstNameEditingController.text = value!,
    );

    final _emailFormField = InputField(
      textEditingController: _emailEditingController,
      inputType: TextInputType.emailAddress,
      hint: "Email",
      icon: const Icon(Icons.email_rounded),
      validatorFunction: (value) {
        if (value!.isEmpty) {
          return "Please enter your Email";
        } else if (!value.contains("@") && !value.contains(".")) {
          return "Enter a valid Email-Address";
        }
        return null;
      },
      onSavedFunction: (value) {
        _emailEditingController.text = value!;
      },
    );

    final _passwordFormField = InputField(
      textEditingController: _passwordEditingController,
      inputType: TextInputType.visiblePassword,
      hint: "Password",
      obscureText: true,
      icon: const Icon(Icons.vpn_key_rounded),
      validatorFunction: (value) {
        if (value!.isEmpty) {
          return "Please enter your Password";
        } else if (value.length < 8) {
          return "Your password is too short";
        }
        return null;
      },
      onSavedFunction: (value) {
        _passwordEditingController.text = value!;
      },
    );

    final _confirmPasswordFormField = InputField(
      textEditingController: _confirmPasswordEditingController,
      inputType: TextInputType.visiblePassword,
      inputAction: TextInputAction.done,
      hint: "confirm password",
      obscureText: true,
      icon: const Icon(Icons.vpn_key_rounded),
      validatorFunction: (value) {
        if (value!.isEmpty) {
          return "Please confirm your password";
        } else if (value != _passwordEditingController.text) {
          return "Your passwords don't match";
        }
        return null;
      },
      onSavedFunction: (value) {
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
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Sign up",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              body: Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                    child: SingleChildScrollView(
                      //controller: _controller,
                      child: Column(
                        children: [
                          _fistNameFormField,
                          const SizedBox(height: 20),
                          _emailFormField,
                          const SizedBox(height: 20),
                          _passwordFormField,
                          const SizedBox(height: 20),
                          _confirmPasswordFormField,
                          const SizedBox(height: 50),
                          ShapedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signUp(
                                    _emailEditingController,
                                    _passwordEditingController,
                                    _firstNameEditingController,
                                    provider);
                              }
                            },
                            title: ("SignUp"),
                          ),
                        ],
                      ),
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

  void signUp(
      TextEditingController _emailEditingController,
      _passwordEditingController,
      _firstNameEditingController,
      SignUpProvider provider) async {
    //* start sign up request
    widget.authService.signUp(
            _emailEditingController.text,
            _passwordEditingController.text,
            _firstNameEditingController.text, ((e) {
      provider.throwError();
      errorMessage(context, "Firebase authentication", e);
    }))

        //* sign up request succeeded
        .then((value) {
      // create custom user out of Firebase User
      CustomUser user = CustomUser(value!);

      // initialize database service
      DatabaseService databaseRef = DatabaseService(FirebaseFirestore.instance);

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
  }
}
