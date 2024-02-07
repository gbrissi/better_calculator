import 'package:better_calculator/services/color_utils.dart';
import 'package:flutter/material.dart';

class CalcHistory extends StatefulWidget {
  const CalcHistory({super.key});

  @override
  State<CalcHistory> createState() => _CalcHistoryState();
}

class _CalcHistoryState extends State<CalcHistory> {
  Color get _backgroundColor => Theme.of(context).colorScheme.primary;
  Color get _textColor => ColorUtils.getAdaptiveTextColor(_backgroundColor);
  Color get _dateTextColor =>
      Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.7);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "January 30th, 2024",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: _dateTextColor,
            ),
          ),
        ),
        Card(
          color: _backgroundColor,
          child: DefaultTextStyle(
            style: TextStyle(
              color: _textColor,
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "12 + 12 =",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "24",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
