import 'package:flutter/material.dart';

import 'components/my_button.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({
    super.key,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scores = [
    Icon(
      Icons.check,
      color: Colors.green,
    ),
    Icon(
      Icons.close,
      color: Colors.red,
    )
  ];

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
                    'Show Questions Here',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              MyButton(
                onTap: () {},
                buttonColor: Colors.green,
                buttonText: 'True',
              ),
              SizedBox(
                height: 20,
              ),
              MyButton(
                onTap: () {},
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
