import 'package:flutter/material.dart';

class RowSeparated extends StatelessWidget {
  const RowSeparated({
    super.key,
    required this.spacing,
    required this.children,
  });
  final List<Widget> children;
  final double spacing;

  List<Widget> get _spacedChildren {
    final List<Widget> spacedChildren = [];
    int lastChildIndex = children.length - 1;
    for (var i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i != lastChildIndex) {
        spacedChildren.add(
          SizedBox(
            width: spacing,
          ),
        );
      }
    }

    return spacedChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _spacedChildren,
    );
  }
}
