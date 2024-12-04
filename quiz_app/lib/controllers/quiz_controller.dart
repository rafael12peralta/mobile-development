import 'package:flutter/material.dart';

import '../models/quiz.dart';

class QuizController {
  int _questionNumber = 0;

  final List<Quiz> _questionBank = [
    Quiz(
        question: "What animation studio produced &quot;Gurren Lagann&quot;?",
        correct_answer: "Gainax",
        incorrect_answers: ["Kyoto Animation", "Pierrot", "A-1 Pictures"]),
    Quiz(
        question: "Who is the armored titan in &quot;Attack On Titan&quot;?",
        correct_answer: "Reiner Braun",
        incorrect_answers: [
          "Armin Arlelt",
          "Mikasa Ackermann",
          "Eren Jaeger"
        ]),
    Quiz(
        question:
            "What is the last name of Edward and Alphonse in the Fullmetal Alchemist series.",
        correct_answer: "Elric",
        incorrect_answers: ["Ellis", "Eliek", "Elwood"]),
    Quiz(
        question:
            "In &quot;To Love-Ru&quot;, Ren and Run are from what planet?",
        correct_answer: "Memorze",
        incorrect_answers: ["Deviluke", "Mistletoe", "Okiwana"]),
    Quiz(
        question:
            "What is the age of Ash Ketchum in Pokemon when he starts his journey?",
        correct_answer: "10",
        incorrect_answers: [, "11", "12", "9"]),
    Quiz(
        question:
            "In &quot;Fairy Tail&quot;, what is the nickname of Natsu Dragneel?",
        correct_answer: "The Salamander",
        incorrect_answers: [
          "The Dragon Slayer",
          "The Dragon",
          "The Demon"
        ]),
    Quiz(
        question:
            "In 2013, virtual pop-star Hatsune Miku had a sponsorship with which pizza chain?",
        correct_answer: "Domino&#039;s",
        incorrect_answers: [
          "Papa John&#039;s",
          "Pizza Hut",
          "Sabarro&#039;s"
        ]),
    Quiz(
        question:
            "Who was given the title &quot;Full Metal&quot; in the anime series &quot;Full Metal Alchemist&quot;?",
        correct_answer: "Edward Elric",
        incorrect_answers: [
          "Alphonse Elric",
          "Van Hohenheim",
          "Izumi Curtis"
        ]),
    Quiz(
        question:
            "In the video game, Half-life, what event started the Half-life universe as we know today?",
        correct_answer: "The Resonance Cascade",
        incorrect_answers: [
          "World War 3",
          "The Xen Attack",
          "The Black Mesa Nuke"
        ]),
    Quiz(
        question:
            "Which video game earned music composer Mike Morasky the most awards for his work?",
        correct_answer: "Portal 2",
        incorrect_answers: [
          "Left 4 Dead 2",
          "Team Fortress 2",
          "Counter-Strike: Global Offensive"
        ])
  ];

  String getCurrentQuestion() {
    return _questionBank[_questionNumber].question;
  }

  String getCurrentAnswer() {
    return _questionBank[_questionNumber].
  }

  bool isQuizFinished() {
    return _questionNumber >= _questionBank.length - 1;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }
}
