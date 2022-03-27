import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messenger/main/screens/splash_cliper.dart';
import 'package:messenger/main/screens/splash_screen.dart';
import 'package:messenger/src/_constants/models/routes.dart';
import 'package:messenger/src/_constants/widgets/error_screen.dart';
import 'package:messenger/src/_constants/widgets/loading_screen.dart';
import 'package:messenger/src/_constants/widgets/shaped_button.dart';
import 'package:messenger/src/authentication/screens/authentication_wrapper_screen.dart';

// followed: https://www.youtube.com/watch?v=EXp0gq9kGxI

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Messenger',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        // Temporarily dark cause of using old VM (ThemeMode.system)
        themeMode: ThemeMode.dark,
        // define main route for deriving children
        onGenerateRoute: RouteGenerator.mainRoute,

        //Splash screen
        home: AnimatedSplashScreen(
          splashTransition: SplashTransition.slideTransition,
          splashIconSize: double.infinity,
          splash: const SplashScreen(),
          backgroundColor: Colors.black,
          nextScreen: FutureBuilder(
              //* Firebase future, that initializes Firebase
              future: _fbApp,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print("error");
                  // TODO error screens
                  return ErrorScreen(
                      error:
                          "Something went wrong: ${snapshot.error.toString()}");
                }
                // if data has arrived, and everything worked successfully
                else if (snapshot.hasData) {
                  return const AuthenticationWrapper();
                }
                // if Stream hasn't finished, loading
                else {
                  return const LoadingScreen();
                }
              }),
        ));
  }
}
