import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class DrawerProvider extends ChangeNotifier {
  bool _isOpen = false;
  bool get isOpen => _isOpen;

  void _setWindowSize(double width) {
    appWindow.size = Size(
      width,
      appWindow.size.height,
    );
  }

  void openDrawer() {
    _setWindowSize(
      appWindow.size.width * 2,
    );

    _isOpen = true;
    notifyListeners();
  }

  void closeDrawer() {
    _setWindowSize(
      appWindow.size.width / 2,
    );

    _isOpen = false;
    notifyListeners();
  }
}
