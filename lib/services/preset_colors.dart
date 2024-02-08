import 'package:flutter/material.dart';

class PresetColors {
  static const Color red = Colors.red;
  static const Color yellow = Colors.yellow;
  static const Color green = Colors.green;
  static const Color blue = Colors.blue;
  static const Color orange = Colors.orange;
  static const Color purple = Colors.purple;
  static const Color indigo = Colors.indigo;
  static final Color purpleBlue = Color(
    int.parse("4B0082", radix: 16),
  ).withOpacity(1.0);

  static final List<Color> colors = [
    red,
    yellow,
    green,
    blue,
    orange,
    purple,
    indigo,
    purpleBlue,
  ];
}
