import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';

void main() {
  // SharedPrefs issue, more information in: https://stackoverflow.com/questions/50687801/flutter-unhandled-exception-missingpluginexceptionno-implementation-found-for
  // ignore: invalid_use_of_visible_for_testing_member
  // SharedPreferences.setMockInitialValues({});

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
