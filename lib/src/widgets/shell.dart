import 'package:better_calculator/src/widgets/title_bar.dart';
import 'package:flutter/material.dart';

class Shell extends StatelessWidget {
  const Shell({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TitleBar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
