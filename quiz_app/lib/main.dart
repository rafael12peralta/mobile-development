import 'package:flutter/material.dart';
import 'package:quiz_app/screens/quiz.dart';
import 'package:quiz_app/screens/start_screen.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Quiz();
  }
}
