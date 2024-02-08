import 'dart:ui';

import 'package:better_calculator/services/shared_prefs.dart';
import 'package:dynamic_color/dynamic_color.dart';
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
    json['colorSeed'] = colorSeed.value;
    json['brightness'] = brightness.name;
    return json;
  }

  ThemeConfig.fromJson(Map<String, dynamic> json)
      : colorSeed = Color(json['colorSeed']),
        brightness = Brightness.values.firstWhere(
          (e) => e.name == json['brightness'],
        );
}

class ThemeProvider extends ChangeNotifier {
  bool _isPrefsLoad = false;
  bool _isAdaptiveThemeLoad = false;
  bool get isLoad => _isPrefsLoad && _isAdaptiveThemeLoad;

  bool _isAdaptiveThemeSet = false;
  bool get isAdaptiveThemeSet => _isAdaptiveThemeSet;

  final ThemeConfig _standardTheme = ThemeConfig(
    brightness: Brightness.dark,
    colorSeed: Color(
      int.parse("4B0082", radix: 16),
    ),
  );

  late ThemeConfig adaptiveThemeCfg = _standardTheme;
  late ThemeConfig manualThemeCfg = _standardTheme;

  ThemeConfig get curTheme =>
      isAdaptiveThemeSet ? adaptiveThemeCfg : manualThemeCfg;
  bool get manualThemeIsDark => manualThemeCfg.brightness == Brightness.dark;

  Future<void> setThemeBrightnessMode() async {
    manualThemeCfg.setBrightness(
      manualThemeIsDark ? Brightness.light : Brightness.dark,
    );

    await _updateManualThemeInStorage();
    notifyListeners();
  }

  Future<void> _updateManualThemeInStorage() async {
    await SharedPrefs.setManualThemeConfig(manualThemeCfg);
  }

  Future<void> setThemeColor(Color color) async {
    manualThemeCfg.setColor(color);
    await _updateManualThemeInStorage();
    notifyListeners();
  }

  Future<void> setAdaptiveThemeState(bool value) async {
    await SharedPrefs.setAdaptiveThemeState(value);
    _isAdaptiveThemeSet = value;
    notifyListeners();
  }

  // TODO: Add a Listener to System Theme changes.
  Future<void> _loadDeviceTheme() async {
    final Color? systemColor = await DynamicColorPlugin.getAccentColor();
    final Color colorSeed = systemColor ?? _standardTheme.colorSeed;
    final Brightness platformBrightness = window.platformBrightness;

    adaptiveThemeCfg = ThemeConfig(
      colorSeed: colorSeed,
      brightness: platformBrightness,
    );

    _isAdaptiveThemeLoad = true;

    notifyListeners();
  }

  Future<void> _getThemeSettingsFromPrefs() async {
    final bool? state = await SharedPrefs.getAdaptiveThemeState();
    _isAdaptiveThemeSet = state ?? _isAdaptiveThemeSet;
    notifyListeners();

    final ThemeConfig? themeConfig = await SharedPrefs.getManualThemeCfg();
    manualThemeCfg = themeConfig ?? manualThemeCfg;
    notifyListeners();

    _isPrefsLoad = true;
    notifyListeners();
  }

  ThemeProvider() {
    _loadDeviceTheme();
    _getThemeSettingsFromPrefs();
  }
}
