import 'package:better_calculator/services/shared_prefs.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  Color colorSeed;
  Brightness brightness;

  ThemeConfig({
    required this.colorSeed,
    required this.brightness,
  });

  void setBrightness(Brightness brightness) {
    this.brightness = brightness;
  }

  void setColor(Color color) {
    colorSeed = color;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['colorSeed'] = colorSeed;
    json['brightness'] = brightness;
    return json;
  }

  ThemeConfig.fromJson(Map<String, dynamic> json)
      : colorSeed = json['colorSeed'],
        brightness = json['brightness'];
}

class ThemeProvider extends ChangeNotifier {
  bool _isLoad = false;
  bool get isLoad => _isLoad;

  bool _isAdaptiveThemeSet = false;
  bool get isAdaptiveThemeSet => _isAdaptiveThemeSet;

  bool get manualThemeIsDark => manualThemeCfg.brightness == Brightness.dark;
  ThemeConfig manualThemeCfg = ThemeConfig(
    brightness: Brightness.dark,
    colorSeed: Color(
      int.parse("4B0082", radix: 16),
    ),
  );

  ThemeConfig get curTheme => manualThemeCfg;

  void setThemeBrightnessMode() {
    manualThemeCfg.setBrightness(
      manualThemeIsDark ? Brightness.light : Brightness.dark,
    );

    notifyListeners();
  }

  void setThemeColor(Color color) {
    manualThemeCfg.setColor(color);
    notifyListeners();
  }

  Future<void> setAdaptiveThemeState(bool value) async {
    await SharedPrefs.setAdaptiveThemeState(value);
    _isAdaptiveThemeSet = value;
    notifyListeners();
  }

  Future<void> _getThemeSettingsFromPrefs() async {
    final bool? state = await SharedPrefs.getAdaptiveThemeState();
    _isAdaptiveThemeSet = state ?? _isAdaptiveThemeSet;
    notifyListeners();

    final ThemeConfig? themeConfig = await SharedPrefs.getManualThemeCfg();
    manualThemeCfg = themeConfig ?? manualThemeCfg;
    notifyListeners();

    _isLoad = true;
    notifyListeners();
  }

  ThemeProvider() {
    _getThemeSettingsFromPrefs();
  }
}
