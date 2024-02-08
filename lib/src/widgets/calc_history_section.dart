
import 'package:flutter/material.dart';

import '../providers/history_provider.dart';
import 'calc_history_card.dart';

class CalcHistorySection extends StatefulWidget {
  const CalcHistorySection({
    super.key,
    required this.calcsHistory,
  });
  final CalcsHistory calcsHistory;

  @override
  State<CalcHistorySection> createState() => _CalcHistorySectionState();
}

class _CalcHistorySectionState extends State<CalcHistorySection> {
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
            widget.calcsHistory.date.stringify(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: _dateTextColor,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.calcsHistory.calculations.length,
          itemBuilder: (_, index) {
            return CalcHistoryCard(
              calculation: widget.calcsHistory.calculations[index],
            );
          },
        )
      ],
    );
  }
}
