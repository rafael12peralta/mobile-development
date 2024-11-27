import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key, required this.buttonText, this.onPressed,
  });

  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: Border.all(
        color: Colors.black
      ),
      onPressed: onPressed,
      child: Text(buttonText),
      color: Theme.of(context).primaryColor,
    );
  }
}