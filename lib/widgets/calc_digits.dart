import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import 'calc_keys_column.dart';
import 'calculator_key.dart';
import 'key_row.dart';

class CalcDigits extends StatefulWidget {
  const CalcDigits({super.key});

  @override
  State<CalcDigits> createState() => _CalcDigitsState();
}

class _CalcDigitsState extends State<CalcDigits> {
  late final _controller = context.read<CalculatorProvider>();

  @override
  Widget build(BuildContext context) {
    return CalcKeysColumn(
      keyRows: [
        KeyRow(
          keys: [
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.escape,
              customTapBehavior: _controller.clearInput,
              iconRepresentation: FontAwesomeIcons.c,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.parenthesisLeft,
              cLabel: "( )",
              customTapBehavior: _controller.addRoundedBrackets,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.percent,
              iconRepresentation: FontAwesomeIcons.percent,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.slash,
              iconRepresentation: FontAwesomeIcons.divide,
            ),
          ],
        ),
        KeyRow(
          keys: [
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.digit7,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.digit8,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.digit9,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.asterisk,
              iconRepresentation: FontAwesomeIcons.xmark,
            ),
          ],
        ),
        KeyRow(
          keys: [
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.digit4,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.digit5,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.digit6,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.minus,
              iconRepresentation: FontAwesomeIcons.minus,
            ),
          ],
        ),
        KeyRow(
          keys: [
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.digit1,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.digit2,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.digit3,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.add,
              iconRepresentation: FontAwesomeIcons.plus,
            ),
          ],
        ),
        KeyRow(
          keys: [
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.digit0,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.comma, // Add "." as a key to press aswell.
              customTapBehavior: () => _controller.addCharacterToCalc("."),
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.backspace,
              customTapBehavior: _controller.removeLastChar,
              iconRepresentation: FontAwesomeIcons.deleteLeft,
            ),
            CalculatorKey(
              logicalKey: LogicalKeyboardKey.equal,
              customTapBehavior: _controller.setResult,
              iconRepresentation: FontAwesomeIcons.equals,
            ),
          ],
        )
      ],
    );
  }
}
