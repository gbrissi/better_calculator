import 'package:better_calculator/widgets/calculator_key.dart';
import 'package:better_calculator/widgets/key_row.dart';
import 'package:better_calculator/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'calc_keys_column.dart';
import 'calc_panel.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TitleBar(),
          Expanded(
            child: Column(
              children: [
                const Expanded(
                  flex: 18,
                  child: CalcPanel(),
                ),
                Expanded(
                  flex: 39,
                  child: CalcKeysColumn(
                    keyRows: [
                      KeyRow(
                        keys: [
                          CalculatorKey(
                            logicalKey: LogicalKeyboardKey.escape,
                          ),
                          CalculatorKey(
                            logicalKey: LogicalKeyboardKey.parenthesisLeft,
                            cLabel: "()",
                          ),
                          CalculatorKey(
                            logicalKey: LogicalKeyboardKey.percent,
                          ),
                          CalculatorKey(
                            logicalKey: LogicalKeyboardKey.slash,
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
                            iconRepresentation: Icons.remove,
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
                            iconRepresentation: Icons.add,
                          ),
                        ],
                      ),
                      KeyRow(
                        keys: [
                          CalculatorKey(
                            logicalKey: LogicalKeyboardKey.digit0,
                          ),
                          CalculatorKey(
                            logicalKey: LogicalKeyboardKey.comma,
                          ),
                          CalculatorKey(
                            logicalKey: LogicalKeyboardKey.backspace,
                            iconRepresentation: Icons.backspace,
                          ),
                          CalculatorKey(
                            logicalKey: LogicalKeyboardKey.equal,
                            // iconRepresentation: Icons.add,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
