import 'package:flutter/material.dart';

import 'package:messenger/src/_constants/models/theme_data.dart';

class ShapedButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  const ShapedButton({required this.title, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onPressed(),
      splashColor: Theme.of(context).colorScheme.secondary,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 45,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(ThemeDataConstants.borderRadius)),
              color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withAlpha(100),
                  blurRadius: 30.0, // soften the shadow
                  spreadRadius: 2.0, //extend the shadow
                )
              ],
            ),
          ),
          Text(
            title,
            style: ThemeDataConstants.buttonText,
          ),
        ],
      ),
    );
  }
}
