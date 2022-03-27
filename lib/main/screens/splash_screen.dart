import 'package:flutter/material.dart';
import 'package:messenger/main/screens/splash_cliper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
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
            ClipPath(
              clipper: CustomSplash(),
              child: Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
