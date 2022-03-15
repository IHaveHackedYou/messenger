import 'package:flutter/material.dart';
import 'package:messenger/src/authentication/screens/logged_out_screen.dart';
import 'package:messenger/src/home/screens/home_screen.dart';

// followed https://www.youtube.com/watch?v=nyvwx7o277U tutorial

//* Add all upcoming routes
class RouteGenerator{
  static Route<dynamic> mainRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      // screen at the beginning, when the user hasn't signed in already
      case "/":
        return MaterialPageRoute(builder: (_) => LoggedOutScreen());
      case "/homePage":
        return MaterialPageRoute(builder: (_) => HomeScreen());
      /*
      case "/homePage/settings"
      case "/homePage/chat"
      case "/homePage/chat/chat_settings"
      case "/signIn"
      case "/signUp"
      */
      // TODO return errorMessage
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Text("Internal error this souldn't happen")));
    }
  }
}