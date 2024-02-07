import 'dart:convert';

import 'package:better_calculator/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String _adaptiveThemeStateKey = "adaptiveThemeState";
  static const String _manualThemeCfgKey = "manualThemeCfg";

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
}
