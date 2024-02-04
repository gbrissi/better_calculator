import 'package:better_calculator/services/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';

class CalcPanel extends StatefulWidget {
  const CalcPanel({super.key});

  @override
  State<CalcPanel> createState() => _CalcPanelState();
}

class _CalcPanelState extends State<CalcPanel> {
  Color get panelColor => Colors.grey.shade900;
  Color get textColor => ColorUtils.getAdaptiveTextColor(panelColor);

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return Material(
          color: panelColor,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              provider.calcInput,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
