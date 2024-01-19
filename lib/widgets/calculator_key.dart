import 'package:better_calculator/providers/calculator_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorKey extends StatefulWidget {
  const CalculatorKey({
    super.key,
    // required this.label,
    required this.keyEvent,
  });
  final KeyEvent keyEvent;
  // final String label;

  @override
  State<CalculatorKey> createState() => _CalculatorKeyState();
}

class _CalculatorKeyState extends State<CalculatorKey> {
  late final _controller = context.read<CalculatorProvider>();

  void _updateExpression() => _controller.addCharacterToCalc(
        widget.keyEvent.character!,
      );

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
