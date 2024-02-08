import 'package:flutter/material.dart';

class CalcHistoryCardAction extends StatelessWidget {
  const CalcHistoryCardAction({
    super.key,
    required this.onTap,
    required this.icon,
    this.color,
  });
  final Color? color;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              icon,
              size: 14,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
