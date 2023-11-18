import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

enum MyTheme {
  dark(ThemeMode.dark),
  light(ThemeMode.light),
  system(ThemeMode.system);

  const MyTheme(this.mode);
  final ThemeMode mode;
}

class ThemeManager {
  final SharedPreferences prefs;

  ThemeManager(this.prefs);

  Future<ThemeManager> instance() async {
    if (prefs.containsKey(THEME_LOCAL_KEY)) {
      try {
        currentThemeMode = MyTheme
            .values[prefs.getInt(THEME_LOCAL_KEY) ?? await resetThemeMode()]
            .mode;
      } catch (e) {
        currentThemeMode = MyTheme.values[await resetThemeMode()].mode;
      }
    }
    return this;
  }

  ThemeMode currentThemeMode = ThemeMode.system;
  ThemeData currentThemeData = ThemeData();

  Future<int> resetThemeMode() async {
    await prefs.remove(THEME_LOCAL_KEY);
    print("Theme mode reset.");
    await prefs.setInt(THEME_LOCAL_KEY, 2);
    return 2; //Default theme mode
  }
}
