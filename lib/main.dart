import 'package:better_calculator/src/app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  runApp(
    const App(),
  );

  doWhenWindowReady(() {
    if (!kIsWeb) {
      const initialSize = Size(320, 640);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    }
  });
}
