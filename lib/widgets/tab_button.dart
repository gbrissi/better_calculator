import 'package:flutter/material.dart';

class TabButton extends StatefulWidget {
  const TabButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.onTap,
  });
  final String text;
  final bool isActive;
  final void Function()? onTap;

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> {
  Color get textColor => widget.isActive
      ? Theme.of(context).colorScheme.primary
      : Theme.of(context).textTheme.bodyMedium!.color!;

  double get fontSize => widget.isActive ? 16 : 15;
  TextDecoration get textDecoration =>
      widget.isActive ? TextDecoration.underline : TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: fontSize,
                // decoration: textDecoration,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
