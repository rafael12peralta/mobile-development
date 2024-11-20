import 'package:quizzler/models/quiz.dart';

class QuizController {
  int _questionNumber = 0;

  final List<Quiz> _questionBank = [
    Quiz(question: "The HTML5 standard was published in 2014.", answer: false),
    Quiz(
        question: "AMD created the first consumer 64-bit processor.",
        answer: true),
    Quiz(
        question:
            "Linus Sebastian is the creator of the Linux kernel, which went on to be used in Linux, Android, and Chrome OS.",
        answer: false)
  ];

  String _getCurrentQuestion() {
    return _questionBank[_questionNumber].question;
  }

  // String get getCurrentQuestion {
  //   return _questionBank[_questionNumber].question;
  // }
}
