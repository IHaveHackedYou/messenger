//* Behavior is finished in sign_up_screen.dart

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:customfirebase/customfirebase.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({Key? key}) : super(key: key);

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//           Provider<AuthenticationService>(
//             create: (_) => AuthenticationService(FirebaseAuth.instance),
//           ),
//           StreamProvider(
//             create: (context) =>
//                 context.read<AuthenticationService>().authStateChanges,
//             initialData: null,
//           )
//         ],
//         child: Forms());
//   }
// }

// class Forms extends StatelessWidget {
//   const Forms({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//           onPressed: () {
//             // TODO implement logic, function to call to sign in user
//             context
//                 .read<AuthenticationService>()
//                 .signIn("123@gmail.com", "123456");
//           }, child: Text("Signin"),
//         );
//   }
// }
