import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key, required this.buttonText, required this.buttonColor, required this.onTap,
  });

  final String buttonText;
  final Color buttonColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(buttonText, style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }
}