import 'dart:math';

class Calculator {
  final int height;
  final int weight;

  Calculator({required this.height, required this.weight});

  double _bmi = 0;

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toString();
  }

  String getResults() {
    if (_bmi >= 25) {
      return "Owerweight";
    } else if (_bmi > 18.5) {
      return "Normal";
    } else {
      return "Underweight";
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return "You have more weight than normal. Please exercise more.";
    } else if (_bmi > 18.5) {
      return "You have a normal body weight. Good Job";
    } else {
      return "You have lower weight than normal. You have to eat a bit more";
    }
  }
}
