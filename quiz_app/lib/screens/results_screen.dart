import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:quiz_app/components/questions_summary.dart";
import "package:quiz_app/controllers/quiz_controller.dart";

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.onRestart, required this.chosenAnswers});

  final void Function() onRestart;

  final List<String> chosenAnswers;
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'questions_index': i,
        'question': questions[i].question,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = getSummaryData().where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              'You answered $numCorrectQuestions of $numTotalQuestions questions correctly!',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 30,
            ),
            QuestionsSummary(getSummaryData()),
            SizedBox(
              height: 30,
            ),
            OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                icon: Icon(Icons.restart_alt),
                onPressed: onRestart,
                label: Text('Restart Quiz!')),
          ],
        ),
      ),
    );
  }
}
