import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider extends ChangeNotifier {
  final Parser p = Parser();
  final ContextModel cm = ContextModel();

  // Starts with empty value.
  String calcInput = "";
  Expression get exp => p.parse(calcInput);
  double get calcResult => exp.evaluate(EvaluationType.REAL, cm);

  void addCharacterToCalc(String char) {
    print("Input: $calcInput, $char");
    calcInput += char;
    print("CalcInput: $calcInput");
    notifyListeners();
  }
}
