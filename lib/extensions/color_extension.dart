import 'package:flutter/material.dart';

extension ColorExtension on Color {
  bool isDark() => computeLuminance() < 0.5;
}
