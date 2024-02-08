
import 'package:better_calculator/src/widgets/small_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class ColorOption extends StatefulWidget {
  const ColorOption({super.key, required this.color});
  final Color color;

  @override
  State<ColorOption> createState() => _ColorOptionState();
}

class _ColorOptionState extends State<ColorOption> {
  late final _controller = context.read<ThemeProvider>();
  
  @override
  Widget build(BuildContext context) {
    return Selector<ThemeProvider, ThemeConfig>(
      selector: (_, provider) => provider.manualThemeCfg,
      builder: (_, theme, __) {
        return SmallCircularButton(
          onTap: () => _controller.setThemeColor(widget.color.withOpacity(1.0)),
          color: widget.color,
          isSelected: theme.colorSeed.value == widget.color.value,
        );
      },
    );
  }
}
