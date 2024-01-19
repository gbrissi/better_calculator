import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  const TitleBar({super.key});
  WindowButtonColors get buttonColors => WindowButtonColors(
        iconNormal: Colors.grey.shade400,
      );

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Material(
        child: Row(
          children: [
            Expanded(child: MoveWindow()),
            MinimizeWindowButton(colors: buttonColors),
            appWindow.isMaximized
                ? RestoreWindowButton(
                    colors: buttonColors,
                  )
                : MaximizeWindowButton(
                    colors: buttonColors,
                  ),
            CloseWindowButton(colors: buttonColors),
          ],
        ),
      ),
    );
  }
}
