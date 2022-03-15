import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/routes.dart';
import 'package:messenger/src/home/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Messenger',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode
            .dark, //*Temporary dark because of using old VM (ThemeMode.system)
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.mainRoute,
        /* home: const HomeScreen() */);
  }
}
