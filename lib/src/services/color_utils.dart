import 'package:better_calculator/src/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class ColorUtils {
  static Color getAdaptiveTextColor(Color backgroundColor) =>
      backgroundColor.isDark() ? Colors.grey.shade200 : Colors.grey.shade900;
}
