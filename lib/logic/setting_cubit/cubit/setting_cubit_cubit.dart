import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repositories/index.dart';

part 'setting_cubit_state.dart';

class SettingCubitCubit extends Cubit<StateTheme> {
  SettingCubitCubit({required this.settingRepository})
      : super(
          const StateTheme(isDarkTheme: false, locale: Locale('th')),
        );
  SettingRepository settingRepository = SettingRepository();
  void setInitialState() async {
    final SharedPreferences shareState = await SharedPreferences.getInstance();
    bool themeState = shareState.getBool("theme") ?? false;
    String? languageState = shareState.getString("languages") ?? "en";

    emit(StateTheme(locale: Locale(languageState), isDarkTheme: themeState));
  }

  void setTheme(String themeName) {
    // bool themeState = settingRepository.setNewTheme(themeName);
    settingRepository.setNewTheme(themeName).then((value) =>
        {emit(StateTheme(isDarkTheme: value, locale: state.locale))});
  }

  void setLocale(Locale localeLanguages) {
    // Locale states = settingRepository.setNewLocale(localeLanguages);
    settingRepository.setNewLocale(localeLanguages).then((value) =>
        {emit(StateTheme(locale: value, isDarkTheme: state.isDarkTheme))});
  }
}
