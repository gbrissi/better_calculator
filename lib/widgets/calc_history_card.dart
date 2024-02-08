import 'package:better_calculator/services/color_utils.dart';
import 'package:flutter/material.dart';

import '../providers/history_provider.dart';

class CalcHistoryCard extends StatefulWidget {
  const CalcHistoryCard({
    super.key,
    required this.calculation,
  });
  final Calculation calculation;

  @override
  State<CalcHistoryCard> createState() => _CalcHistoryState();
}

class _CalcHistoryState extends State<CalcHistoryCard> {
  Color get _backgroundColor => Theme.of(context).colorScheme.primary;
  Color get _textColor => ColorUtils.getAdaptiveTextColor(_backgroundColor);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _backgroundColor,
      child: DefaultTextStyle(
        style: TextStyle(
          color: _textColor,
        ),
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.calculation.expression,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                widget.calculation.result,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
