import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/widgets/shaped_button.dart';
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
    ], child: const SignOutScreen());
  }
}

class SignOutScreen extends StatelessWidget {
  const SignOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firebaseUser = context.watch<User?>();
    // when user already has signed in go directly to homepage
    if (_firebaseUser != null) {
      // user future delayed to avoid "setState() or markNeedsBuild called during build" error
      // more infos: https://stackoverflow.com/questions/47592301/setstate-or-markneedsbuild-called-during-build
      //Future.delayed(Duration.zero,
      //    () async => Navigator.of(context).pushReplacementNamed("/homePage"));
    }
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Text(
                "Fancy app name",
                style: TextStyle(fontSize: 40,
                    //color: Theme.of(context).colorScheme.onBackground,
                    shadows: [
                      Shadow(
                        color: Theme.of(context).colorScheme.primary,
                        blurRadius: 20,
                      )
                    ]),
              ),
              const SizedBox(height: 50),
              const FlutterLogo(size: 200),
              const Spacer(),
              ShapedButton(
                  onPressed: () => Navigator.of(context).pushNamed("/signIn",
                      arguments: context.read<AuthenticationService>()),
                  title: ("SignIn")),
              const SizedBox(height: 10),
              // Sign in button

              // Sign up button
              ShapedButton(
                  onPressed: () => Navigator.of(context).pushNamed("/signUp",
                      arguments: context.read<
                          AuthenticationService>() /* .read<AuthenticationService>().signUp */),
                  title: ("SignUp")),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
