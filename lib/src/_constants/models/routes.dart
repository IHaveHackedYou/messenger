import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/authentication/screens/authentication_wrapper_screen.dart';
import 'package:messenger/src/authentication/screens/sign_up_screen.dart';
import 'package:messenger/src/chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:messenger/src/home/screens/home_screen.dart';

// followed https://www.youtube.com/watch?v=nyvwx7o277U tutorial

//* Add all upcoming routes
class RouteGenerator {
  static Route<dynamic> mainRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // screen at the beginning, wrapper decides whether user gets redirected to home page or first has to sign in/up
      case "/":
        return MaterialPageRoute(builder: (_) => const AuthenticationWrapper());

      case "/homePage":
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case "/homePage/chat":
        if (args is ChatUser) {
          return MaterialPageRoute(builder: (_) => ChatScreen(user: args));
        }
        //TODO add error message
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                body: Text("Internal error this souldn't happen")));

      case "/signUp":
        return MaterialPageRoute(
            builder: (_) =>
                SignUpScreen(authService: args as AuthenticationService));

      case "/signIn":
        return MaterialPageRoute(
            builder: (_) =>
                SignUpScreen(authService: args as AuthenticationService));
      /*
      case "/homePage/settings"
      case "/homePage/chat/chat_settings"
      case "/signIn"
      */
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                body: Text("Internal error this shouldn't happen")));
    }
  }
}
