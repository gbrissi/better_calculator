import 'package:flutter/material.dart';

class CalculatorProvider extends ChangeNotifier {
  String formattedExpression = "";
  // final evaluator = const ExpressionEvaluator();
  // Expression get expression => Expression.parse(formattedExpression);
  // get expressionResult => evaluator.eval(expression); 

  void addCharacterToCalc(String char) {
    formattedExpression += char;
    notifyListeners();
  }

  // TODO: Evaluate in Widget. Evaluate expression
  // var r = evaluator.eval(expression, context);
}
