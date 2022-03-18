import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:messenger/src/_constants/models/routes.dart';
import 'package:messenger/src/authentication/screens/signed_out_screen.dart';

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
        home: FutureBuilder(
            //* Firebase future, that initializes Firebase
            future: _fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("error");
                // TODO error screens
                return Text(
                    "Something went wrong: ${snapshot.error.toString()}");
              }
              // if data has arrived, and everything worked successfully
              else if(snapshot.hasData){
                return AuthenticationWrapper();
              }
              // if Stream hasn't finished, loading
              else{
                // TODO loading screens
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
