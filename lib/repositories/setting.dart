import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingRepository {
  bool themeState = false;
  Locale languages = const Locale('th');

  Future<bool> setNewTheme(String themeName) async {
    final SharedPreferences shareTheme = await SharedPreferences.getInstance();
    if (themeName == 'light') {
      shareTheme.setBool("theme", true);
      return true;
    } else if (themeName == 'dark') {
      shareTheme.setBool("theme", false);
      return false;
    }
    return false;
  }

  bool getTheme() {
    return themeState;
  }

  Future<Locale> setNewLocale(Locale locale) async {
    final SharedPreferences shareLanguage =
        await SharedPreferences.getInstance();
    languages = locale;
    shareLanguage.setString("languages", languages.toString());

    return languages;
  }

  Locale getLocale() {
    return languages;
  }
}
