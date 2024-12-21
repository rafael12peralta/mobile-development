import 'package:bml_calculator/screen/input_screen.dart';
import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  const Results(
      {super.key,
      required this.title,
      required this.results,
      required this.bmiResult,
      required this.interpretation});

  final String title;
  final String results;
  final String bmiResult;
  final String interpretation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              child: Text(
                'Your Results',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
              color: Color(0xFF1D1E33),
              cardChild: Column(
                children: [
                  Text(results),
                  Text(bmiResult),
                  Text(interpretation),
                ],
              ),
            ),
          ),
          MyButton(
            label: 'RECALCULATE',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
