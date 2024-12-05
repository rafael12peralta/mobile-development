import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/trivia.png',
            width: 250,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Quiz App',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          SizedBox(
            height: 25,
          ),
          OutlinedButton.icon(
              icon: Icon(Icons.arrow_right_alt),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
              onPressed: startQuiz,
              label: Text('Start Quiz'))
        ],
      ),
    );
  }
}
