import 'package:flutter/material.dart';

import 'key_row.dart';

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
