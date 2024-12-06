import 'package:flutter/material.dart';

import '../models/quiz_question.dart';

final questions = [
  Quiz(question: "Who discovered the Law of Gravity?", answers: [
    "Sir Isaac Newton",
    "Galileo Galilei",
    "Charles Darwin",
    "Albert Einstein"
  ]),
  Quiz(question: "What does DNA stand for?", answers: [
    "Deoxyribonucleic Acid",
    "Deoxyribogenetic Acid",
    "Deoxyribogenetic Atoms",
    "Detoxic Acid"
  ]),
  Quiz(
      question: "Which element has the highest melting point?",
      answers: ["Carbon", "Tungsten", "Platinum", "Osmium"]),
  Quiz(
      question: "What is the unit of electrical resistance?",
      answers: ["Ohm", "Mho", "Tesla", "Joule"]),
  Quiz(
      question: "What is the powerhouse of the cell?",
      answers: ["Mitochondria", "Ribosome", "Redbull", "Nucleus"]),
  Quiz(
      question: "The asteroid belt is located between which two planets?",
      answers: [
        "Mars and Jupiter",
        "Jupiter and Saturn",
        "Mercury and Venus",
        "Earth and Mars"
      ]),
  Quiz(
      question: "How many planets are in our Solar System?",
      answers: ["Eight", "Nine", "Seven", "Ten"]),
];
