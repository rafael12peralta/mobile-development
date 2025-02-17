import 'package:bml_calculator/screen/input_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0XFF0A0E21),
        scaffoldBackgroundColor: Color(0XFF0A0E21),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0XFF0A0E21),
        )
      ),
      home: InputScreen(),
    );
  }
}
