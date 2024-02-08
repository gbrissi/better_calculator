import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'app.dart';

void main() {
  runApp(
    const App(),
  );

  doWhenWindowReady(() {
    const initialSize = Size(320, 640);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
