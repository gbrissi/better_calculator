import 'package:better_calculator/providers/theme_provider.dart';
import 'package:better_calculator/widgets/small_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          onTap: () => _controller.setThemeColor(widget.color),
          color: widget.color,
          isSelected: theme.colorSeed.value == widget.color.value,
        );
      },
    );
  }
}
