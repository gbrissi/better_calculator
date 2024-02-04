import 'package:better_calculator/widgets/key_row.dart';
import 'package:flutter/material.dart';

class CalcKeysColumn extends StatelessWidget {
  const CalcKeysColumn({
    super.key,
    required this.keyRows,
  });
  final List<KeyRow> keyRows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: keyRows.map(
        (row) => Expanded(child: row),
      ).toList(),
    );
  }
}
