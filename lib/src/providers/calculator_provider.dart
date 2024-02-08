import 'package:better_calculator/src/extensions/double_extension.dart';
import 'package:better_calculator/src/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import '../services/regex_utils.dart';
import 'history_provider.dart';

class EvaluationResult {
  final double? result;
  final bool isError;

  EvaluationResult({
    this.result,
    this.isError = false,
  });
}

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
    stringValue = _generalViewNumberFormatting(value.toExact());
    stringValue = _removeUnnecessaryFloatingPoint(stringValue);

    return stringValue;
  }

  String get inputLastChar => userInput.isNotEmpty
      ? userInput.substring(userInput.length - 1, userInput.length)
      : userInput;

  void setUserInput(String input) {
    if (_isSetResultError) _isSetResultError = false;
    userInput = _inputDefaultFiltering(input);

    notifyListeners();
  }

  void addCharactersToCalc(String char) {
    if (_isSetResultError) _isSetResultError = false;
    userInput = userInput.insertCharAtPosition(char, cursorPosition);
    userInput = _inputDefaultFiltering(userInput);

    notifyListeners();
  }

  String _inputDefaultFiltering(input) {
    late String userInput;
    userInput = _removeDuplicatedFloatingPoints(input);
    // userInput = _removeDuplicatedOperators(input);
    userInput = _removeLeadingZero(input);

    return userInput;
  }

  void setResult() {
    if (!_parseResult.isError) {
      final String oldInput = userInput;

      // Filter userInput to get the appropriated result.
      userInput = calcResult?.toExact() ?? "";
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

  String _removeDuplicatedFloatingPoints(String input) {
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

    addCharactersToCalc(char);
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

  String _generalViewNumberFormatting(String input) =>
      _replaceDecimalWithComma(input);

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

// String _removeDuplicatedOperators(String input) {
//   String result = "";
//   String? lastOperator;

//   for (int i = 0; i < input.length; i++) {
//     String currentChar = input[i];
//     final bool isOperator = RegexUtils.operatorRegExp.hasMatch(currentChar);
//     final bool isParenthesis = currentChar == "(" || currentChar == ")";

//     // If the current character is an operator and not a parenthesis
//     print("Curr: $lastOperator, $currentChar, $result");
//     // If the current character is an operator and not a parenthesis
//     if (isOperator && !isParenthesis) {
//       // If the last operator is not null and different from the current one, replace it
//       if (lastOperator != null && currentChar != lastOperator) {
//         result = result.substring(
//             0, result.length - 1); // Remove the last added character
//       }
//       result += currentChar; // Add the current operator
//       lastOperator = currentChar; // Update lastOperator
//     } else {
//       // If it's not an operator or parenthesis, add it to the result
//       result += currentChar;
//       // Reset lastOperator
//       lastOperator = null;
//     }
//   }
//   print("After: $result");

//   return result;
// }
