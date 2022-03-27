import 'package:customfirebase/customfirebase.dart';
import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/widgets/error_screen.dart';
import 'package:messenger/src/authentication/screens/authentication_wrapper_screen.dart';
import 'package:messenger/src/authentication/screens/sign_in_screen.dart';
import 'package:messenger/src/authentication/screens/sign_up_screen.dart';
import 'package:messenger/src/chat/screens/chat_screen.dart';
import 'package:messenger/src/home/screens/home_screen.dart';
import 'package:messenger/src/home/screens/search_screen.dart';

// followed https://www.youtube.com/watch?v=nyvwx7o277U tutorial

//* Add all upcoming routes
class RouteGenerator {
  static Route<dynamic> mainRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // screen at the beginning, wrapper decides whether user gets redirected to home page or first has to sign in/up
      case "/":
        return MaterialPageRoute(builder: (_) => const AuthenticationWrapper());
      case "/homePage/search":
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case "/homePage":
        if (args is CustomUser) {
          return MaterialPageRoute(
              builder: (_) => HomeScreen(
                    myUser: args,
                  ));
        }

        return MaterialPageRoute(
            builder: (_) => const ErrorScreen(error: "This should not happen"));

      case "/homePage/chat":
        if (args is CustomUser) {
          return MaterialPageRoute(builder: (_) => ChatScreen(user: args));
        }

        return MaterialPageRoute(
            builder: (_) => const ErrorScreen(error: "This should not happen"));

      case "/signUp":
        return MaterialPageRoute(
            builder: (_) =>
                SignUpScreen(authService: args as AuthenticationService));

      case "/signIn":
        return MaterialPageRoute(
            builder: (_) =>
                SignInScreen(authService: args as AuthenticationService));
      /*
      case "/homePage/settings"
      case "/homePage/chat/chat_settings"
      case "/signIn"
      */
      default:
        return MaterialPageRoute(
            builder: (_) => const ErrorScreen(error: "This should not happen"));
    }
  }
}
