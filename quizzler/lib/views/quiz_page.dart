import 'package:flutter/material.dart';
import 'package:quizzler/controllers/quiz_controller.dart';

import 'components/my_button.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  final quizBrain = QuizController();
  List<Icon> scores = [];

  void checkCurrentAnswer(bool userAnswer){
    setState(() {
      final currentAnswer = quizBrain.getCurentAnswer();
      if(currentAnswer == userAnswer){
        scores.add(Icon(Icons.check, color: Colors.green), );
      } else {
        scores.add(Icon(Icons.close, color: Colors.red,));
      }

      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey.shade900,
          title: Text(
            'Quiz App',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    quizBrain.getCurrentQuestion(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              MyButton(
                onTap: () {
                  checkCurrentAnswer(true);
                },
                buttonColor: Colors.green,
                buttonText: 'True',
              ),
              SizedBox(
                height: 20,
              ),
              MyButton(
                onTap: () {
                  checkCurrentAnswer(false);
                },
                buttonColor: Colors.red,
                buttonText: 'False',
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: scores,
              ),
            ],
          ),
        ));
  }
}
