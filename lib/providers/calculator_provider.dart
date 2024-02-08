import 'package:better_calculator/extensions/string_extension.dart';
import 'package:better_calculator/services/regex_utils.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'history_provider.dart';

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
  HistoryProvider? _historyProvider;
  final Parser p = Parser();
  final ContextModel cm = ContextModel();
  bool _isSetResultError = false;

  final TextEditingController inputController = TextEditingController();

  int get cursorPosition => inputController.selection.baseOffset;
  late String _userInput = inputController.text;
  String get userInput => _userInput;
  String get viewInput => _filterInput(userInput);
  set userInput(String value) {
    _userInput = value;
    _keepReactiveBehavior();
  }

  void setHistoryProvider(HistoryProvider provider) {
    _historyProvider = provider;
    notifyListeners();
  }

  void _keepReactiveBehavior() {
    // Gets the char length diff between the new value and the old one.
    final int oldTextLength = inputController.text.length;
    final int curTextLength = viewInput.length;
    final int lengthDiff = curTextLength - oldTextLength;

    final int latestCursorPosition = cursorPosition;
    // Update text value and keep old position updated.
    inputController.text = viewInput;
    inputController.selection = TextSelection.collapsed(
      offset: latestCursorPosition + lengthDiff,
    );
  }

  EvaluationResult get _parseResult {
    try {
      return EvaluationResult(
        result: p.parse(_processStringToCalc(userInput)).evaluate(
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

  void moveCursorRight() {
    if (cursorPosition < inputController.text.length) {
      final newPosition = TextSelection.collapsed(offset: cursorPosition + 1);
      inputController.selection = newPosition;
    }
  }

  void moveCursorLeft() {
    if (cursorPosition > 0) {
      final newPosition = TextSelection.collapsed(offset: cursorPosition - 1);
      inputController.selection = newPosition;
    }
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
    if (_isSetResultError) _isSetResultError = false;
    userInput = userInput.insertCharAtPosition(char, cursorPosition);
    userInput = _inputDefaultFiltering(userInput);

    notifyListeners();
  }

  String _inputDefaultFiltering(input) {
    late String userInput;
    userInput = _removeDuplicatedDots(input);
    userInput = _removeDuplicateOperators(input);
    // userInput = _removeLeadingZero(input);

    return userInput;
  }

  void setResult() {
    if (!_parseResult.isError) {
      final String oldInput = userInput;

      // Filter userInput to get the appropriated result.
      userInput = calcResult?.toString() ?? "";
      userInput = _replaceDecimalWithComma(userInput);
      userInput = _inputDefaultFiltering(userInput);
      userInput = _removeUnnecessaryFloatingPoint(userInput);

      // Add the result to the HistoryProvider.
      if (_historyProvider != null && oldInput != userInput) {
        _historyProvider!.addHistory(
          Calculation(
            expression: oldInput,
            result: userInput,
          ),
        );
      }
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

  void addRoundedBrackets() {
    String openRoundedBracket = "(";
    String closedRoundedBracket = ")";
    late final String char;

    bool isLastCharOpen = inputLastChar == openRoundedBracket;
    int openOccur = userInput.countOccurrences(openRoundedBracket);
    int closedOccur = userInput.countOccurrences(closedRoundedBracket);
    bool isAllBracketsClosed = openOccur - closedOccur == 0;

    if (isLastCharOpen || isAllBracketsClosed) {
      char = openRoundedBracket;
    } else {
      char = closedRoundedBracket;
    }

    addCharacterToCalc(char);
  }

  void removeSelectedChar() {
    if (userInput.isNotEmpty) {
      userInput = userInput.removeCharAt(
        cursorPosition - 1,
      );
    }

    notifyListeners();
  }

  void clearInput() {
    userInput = "";
    notifyListeners();
  }

  String _processStringToCalc(String input) {
    List<String> result = [];
    for (int i = 0; i < input.length; i++) {
      if (input[i] == '(' &&
          i - 1 >= 0 &&
          !RegexUtils.operatorRegExp.hasMatch(
            input[i - 1],
          )) {
        result.add('*(');
      } else if (input[i] == ')' &&
          i + 1 < input.length &&
          !RegexUtils.operatorRegExp.hasMatch(
            input[i + 1],
          )) {
        result.add(')*');
      } else {
        result.add(input[i]);
      }
    }

    return result.join('');
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

  // TODO: _addDot
  String _generalViewNumberFormatting(String input) =>
      _replaceDecimalWithComma(input);

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


// String _addDotToNumbers(String input) {
//   const String splitChar = ",";
//   final List<String> splitNumericalsTypes = input.split(splitChar);

//   String integers = splitNumericalsTypes[0];
//   int totalIntegersToCalc = integers.length;

//   while (totalIntegersToCalc > 3) {
//     totalIntegersToCalc = totalIntegersToCalc - 3;
//     integers = integers.insertCharAtPosition(".", totalIntegersToCalc);
//   }

//   bool isDecimalsIncluded = splitNumericalsTypes.length > 1;
//   if (!isDecimalsIncluded) return integers;
//   final String decimals = splitNumericalsTypes[1];
//   return "$integers$splitChar$decimals";
// }