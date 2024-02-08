import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart';
import '../services/color_utils.dart';
import 'calc_history_card_button.dart';

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
  late final _controller = context.read<CalculatorProvider>();
  Color get _backgroundColor => Theme.of(context).colorScheme.primary;
  Color get _textColor => ColorUtils.getAdaptiveTextColor(_backgroundColor);

  void _copyExpression() {
    _controller.setUserInput(
      widget.calculation.expression,
    );
  }

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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 4,
                    ),
                    child: CalcHistoryCardAction(
                      icon: Icons.copy,
                      onTap: _copyExpression,
                      color: _textColor,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            widget.calculation.expression,
                            maxLines: 1,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                widget.calculation.result,
                style: const TextStyle(
                  fontSize: 24,
                  overflow: TextOverflow.ellipsis,
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
