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
        answer: false),
    Quiz(
        question:
            'Early RAM was directly seated onto the motherboard and could not be easily removed.',
        answer: true),
    Quiz(
        question: 'The first dual-core CPU was the Intel Pentium D.',
        answer: false),
    Quiz(
        question:
            'The last Windows operating system to be based on the Windows 9x kernel was Windows 98.',
        answer: false),
    Quiz(
        question:
            'The open source program Redis is a relational database server.',
        answer: false),
    Quiz(
        question: 'Android versions are named in alphabetical order.',
        answer: true),
    Quiz(
        question:
            'To bypass US Munitions Export Laws, the creator of the PGP published all the source code in book form. ',
        answer: true),
    Quiz(
        question:
            'All program codes have to be compiled into an executable file in order to be run. This file can then be executed on any machine.',
        answer: false)
  ];

  String getCurrentQuestion() {
    return _questionBank[_questionNumber].question;
  }

  bool getCurentAnswer() {
    return _questionBank[_questionNumber].answer;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  bool isQuizFinished() {
    return _questionNumber >= _questionBank.length - 1;
  }

  void resetQuiz(){
    _questionNumber = 0;
  }
}
