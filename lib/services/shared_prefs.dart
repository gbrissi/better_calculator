import 'dart:convert';

import 'package:better_calculator/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/history_provider.dart';

class SharedPrefs {
  static const String _adaptiveThemeStateKey = "adaptiveThemeState";
  static const String _manualThemeCfgKey = "manualThemeCfg";
  static const String _customColorsKey = "customColors";
  static const String _calculationHistoryKey = "calculationHistory";

  static Future<SharedPreferences> _getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static String _encodeObject({
    required Map<String, dynamic> Function() jsonBuilder,
  }) {
    final jsonObj = jsonBuilder();
    return jsonEncode(jsonObj);
  }

  static T _decodeStoredObject<T>({
    required String value,
    required T Function(Map<String, dynamic> storedObj) callback,
  }) {
    final Map<String, dynamic> storedObj = jsonDecode(value);
    return callback(storedObj);
  }

  static Future<void> setAdaptiveThemeState(bool state) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_adaptiveThemeStateKey, state);
  }

  static Future<bool?> getAdaptiveThemeState() async {
    final prefs = await _getPrefs();
    final bool? themeState = prefs.getBool(_adaptiveThemeStateKey);
    return themeState;
  }

  static Future<void> addCustomColor(Color color) async {
    final prefs = await _getPrefs();
    List<Color>? storedColors = await getCustomColors();
    storedColors = storedColors != null ? [...storedColors, color] : [color];
    final String stringifiedColors = jsonEncode(
      storedColors.map((e) => e.value.toString()).toList(),
    );

    await prefs.setString(
      _customColorsKey,
      stringifiedColors,
    );
  }

  static Future<List<Color>?> getCustomColors() async {
    List<Color>? colors;
    final prefs = await _getPrefs();
    final String? colorsVal = prefs.getString(_customColorsKey);
    if (colorsVal != null) {
      final List<String> decodedColorsVal =
          jsonDecode(colorsVal).cast<String>();
      colors = decodedColorsVal.map((e) => Color(int.parse(e))).toList();
    }

    return colors;
  }

  static Future<void> removeCustomColor(Color color) async {
    final prefs = await _getPrefs();
    final String? colorsVal = prefs.getString(_customColorsKey);
    if (colorsVal != null) {
      final List<String> decodedColorsVal =
          jsonDecode(colorsVal).cast<String>();
      final int colorIndex = decodedColorsVal.indexOf(color.value.toString());
      if (colorIndex != -1) decodedColorsVal.removeAt(colorIndex);
      final encodedColorsVal = jsonEncode(decodedColorsVal);

      await prefs.setString(
        _customColorsKey,
        encodedColorsVal,
      );
    }
  }

  static Future<void> setManualThemeConfig(ThemeConfig themeCfg) async {
    final prefs = await _getPrefs();
    await prefs.setString(
      _manualThemeCfgKey,
      _encodeObject(
        jsonBuilder: themeCfg.toJson,
      ),
    );
  }

  static Future<ThemeConfig?> getManualThemeCfg() async {
    ThemeConfig? themeCfg;
    final prefs = await _getPrefs();
    final String? encodedThemeCfg = prefs.getString(_manualThemeCfgKey);
    if (encodedThemeCfg != null) {
      themeCfg = _decodeStoredObject<ThemeConfig>(
        value: encodedThemeCfg,
        callback: (storedObj) => ThemeConfig.fromJson(storedObj),
      );
    }

    return themeCfg;
  }

  static Future<List<CalcsHistory>?> getHistory() async {
    List<CalcsHistory>? history;
    final prefs = await _getPrefs();
    final String? calcsVal = prefs.getString(_calculationHistoryKey);
    if (calcsVal != null) {
      final List<String> decodedCalscVal = jsonDecode(calcsVal).cast<String>();
      history = decodedCalscVal
          .map((e) => CalcsHistory.fromJson(jsonDecode(e)))
          .toList();
    }

    return history;
  }

  static Future<void> setHistory(List<CalcsHistory>? calculations) async {
    final prefs = await _getPrefs();
    final List<String>? encodedCalcs =
        calculations?.map((e) => jsonEncode(e.toJson())).toList();

    if (encodedCalcs != null) {
      await prefs.setString(
        _calculationHistoryKey,
        jsonEncode(encodedCalcs),
      );
    }
  }
}
