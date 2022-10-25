import 'package:flutter/material.dart';

class SettingRepository {
  bool themeState = false;
  Locale languages = const Locale('th');
  bool setNewTheme(String themeName) {
    if (themeName == 'light') {
      return true;
    } else if (themeName == 'dark') {
      return false;
    }
    return false;
  }

  bool getTheme() {
    return themeState;
  }

  Locale setNewLocale(Locale locale) {
    languages = locale;
    print(languages);
    return languages;
  }

  Locale getLocale() {
    return languages;
  }
}
