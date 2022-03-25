import 'package:flutter/material.dart';
import 'package:messenger/src/_constants/models/theme_data.dart';

class InputField extends StatelessWidget {
  final String hint;
  final TextEditingController? textEditingController;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool obscureText;
  final Icon icon;
  final String? Function(String?)? validatorFunction;
  final void Function()? onTap;
  final void Function(String?)? onSavedFunction;

  const InputField({
    Key? key,
    this.hint = "",
    this.textEditingController,
    this.inputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.icon = const Icon(Icons.no_food),
    this.validatorFunction,
    this.onTap,
    this.onSavedFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: inputType,
      textInputAction: inputAction,
      autofocus: false,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: icon,
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeDataConstants.borderRadius),
        ),
      ),
      validator: validatorFunction,
      onTap: onTap,
      onSaved: onSavedFunction,
    );
  }
}
