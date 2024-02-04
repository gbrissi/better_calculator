import 'package:better_calculator/widgets/calculator_key.dart';
import 'package:flutter/material.dart';

class KeyRow extends StatelessWidget {
  const KeyRow({
    super.key,
    required this.keys,
  });
  final List<CalculatorKey> keys;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: keys
          .map(
            (key) => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: key,
              ),
            ),
          )
          .toList(),
    );
  }
}
