import 'package:flutter/material.dart';

enum CTab {
  appearance,
  history,
}

class TabProvider extends ChangeNotifier {
  CTab _tab = CTab.appearance;
  CTab get tab => _tab;

  void setTab(CTab tab) {
    _tab = tab;
    notifyListeners();
  }
}
