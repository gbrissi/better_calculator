import 'package:better_calculator/extensions/string_extension.dart';
import 'package:better_calculator/services/regex_utils.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class EvaluationResult {
  final double? result;
  final bool isError;

  EvaluationResult({
    this.result,
    this.isError = false,
  });
}

// TODO: Add precision to double by adding a lib.
class CalculatorProvider extends ChangeNotifier {
  final Parser p = Parser();
  final ContextModel cm = ContextModel();
  bool _isSetResultError = false;

  String userInput = "";
  String get viewInput => _filterInput(userInput);

  EvaluationResult get _parseResult {
    try {
      return EvaluationResult(
        result: p.parse(userInput).evaluate(
              EvaluationType.REAL,
              cm,
            ),
      );
    } catch (err) {
      return EvaluationResult(
        isError: true,
      );
    }
  }

  bool get showParseError => _parseResult.isError && _isSetResultError;
  double? get calcResult => _parseResult.result;
  String get calcResultView => _formatCalcResult(calcResult);

  String _removeUnnecessaryFloatingPoint(String input) {
    if (input.contains(',')) {
      // If the double value has decimals
      List<String> parts = input.split(',');
      if (int.tryParse(parts[1]) == 0) {
        // If decimals are all zero
        return parts[0];
      }
    }

    return input;
  }

  String _formatCalcResult(double? value) {
    String stringValue = "";
    if (value == null) return stringValue;
    stringValue = _generalViewNumberFormatting(value.toString());
    stringValue = _removeUnnecessaryFloatingPoint(stringValue);

    return stringValue;
  }

  String get inputLastChar => userInput.isNotEmpty
      ? userInput.substring(userInput.length - 1, userInput.length)
      : userInput;

  void addCharacterToCalc(String char) {
    print("Result: $calcResult");

    if (_isSetResultError) _isSetResultError = false;
    userInput += char;
    userInput = _inputDefaultFiltering(userInput);

    notifyListeners();
  }

  String _inputDefaultFiltering(input) {
    late String userInput;
    userInput = _removeDuplicatedDots(input);
    userInput = _removeDuplicateOperators(input);
    userInput = _removeLeadingZero(input);

    return userInput;
  }

  void setResult() {
    // TODO: Send result to History Provider.
    if (!_parseResult.isError) {
      userInput = calcResult?.toString() ?? "";
      userInput = _replaceDecimalWithComma(userInput);
      userInput = _inputDefaultFiltering(userInput);
      userInput = _removeUnnecessaryFloatingPoint(userInput);
    } else {
      _isSetResultError = true;
    }

    notifyListeners();
  }

  String _removeDuplicatedDots(String input) {
    // Split the input string by "."
    List<String> parts = input.split(".");

    // Join the parts together, omitting empty parts and preserving the first one
    String result = parts.first +
        (parts.length > 1
            ? ".${parts.skip(1).where((part) => part.isNotEmpty).join("")}"
            : "");

    return result;
  }

  void addRoundedBrackets() => addCharacterToCalc("()");

  void removeLastChar() {
    if (userInput.isNotEmpty) {
      userInput = userInput.substring(0, userInput.length - 1);
    }

    notifyListeners();
  }

  void clearInput() {
    userInput = "";
    notifyListeners();
  }

  String _addDotToNumbers(String input) {
    const String splitChar = ",";
    final List<String> splitNumericalsTypes = input.split(splitChar);

    String integers = splitNumericalsTypes[0];
    int totalIntegersToCalc = integers.length;

    while (totalIntegersToCalc > 3) {
      totalIntegersToCalc = totalIntegersToCalc - 3;
      integers = integers.insertCharAtPosition(".", totalIntegersToCalc);
    }

    bool isDecimalsIncluded = splitNumericalsTypes.length > 1;
    if (!isDecimalsIncluded) return integers;
    final String decimals = splitNumericalsTypes[1];
    return "$integers$splitChar$decimals";
  }

  String _replaceDecimalWithComma(String numberString) {
    int lastIndex = numberString.lastIndexOf('.');

    return lastIndex != -1
        ? numberString.replaceRange(lastIndex, lastIndex + 1, ",")
        : numberString;
  }

  String _filterInput(String input) {
    List<String> matches = RegexUtils.digitsRegExp
        .allMatches(input)
        .map((match) => match.group(0)!)
        .toList();

    for (int i = 0; i < matches.length; i++) {
      if (double.tryParse(matches[i]) != null) {
        matches[i] = _generalViewNumberFormatting(matches[i]);
      }
    }

    final String filteredInput = matches.join("");
    return filteredInput;
  }

  String _generalViewNumberFormatting(String input) => _addDotToNumbers(
        _replaceDecimalWithComma(input),
      );

  String _removeDuplicateOperators(String input) {
    String result = "";
    String lastOperator = "";

    for (int i = 0; i < input.length; i++) {
      String currentChar = input[i];
      final bool isOperator = RegexUtils.operatorRegExp.hasMatch(currentChar);
      final bool isParenthesis = currentChar == "(" || currentChar == ")";

      // Check if the current character is an operator
      if (isOperator && !isParenthesis) {
        lastOperator = currentChar;
      } else {
        // If the current character is not an operator or a parenthesis, append the last operator (if any)
        if (lastOperator.isNotEmpty) {
          result += lastOperator;
          lastOperator = ""; // Reset the last operator
        }
        result += currentChar;
      }
    }

    // Append the last operator if any
    if (lastOperator.isNotEmpty) {
      result += lastOperator;
    }

    return result;
  }

  String _removeLeadingZero(String input) {
    List<String> matches = RegexUtils.digitsRegExp
        .allMatches(input)
        .map((match) => match.group(0)!)
        .toList();

    // Iterate through the list
    for (int i = 0; i < matches.length; i++) {
      // Check if the current element is a number
      if (double.tryParse(matches[i]) != null) {
        final String number = matches[i];
        if (number.startsWith('0') && number.length > 1) {
          matches[i] = number.substring(1);
        }
      }
    }

    return matches.join("");
  }
}

// String openRoundedBracket = "(";
// String closedRoundedBracket = ")";
// late final String char;

// bool isLastCharOpen = inputLastChar == openRoundedBracket;
// int openOccur = userInput.countOccurrences(openRoundedBracket);
// int closedOccur = userInput.countOccurrences(closedRoundedBracket);
// bool isAllBracketsClosed = openOccur - closedOccur == 0;

// if (isLastCharOpen || isAllBracketsClosed) {
//   char = openRoundedBracket;
// } else {
//   char = closedRoundedBracket;
// }

// TODO: Allow moving across the expression with arrow keys.