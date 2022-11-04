import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/index.dart';

part 'setting_cubit_state.dart';

class SettingCubitCubit extends Cubit<StateTheme> {
  SettingCubitCubit({required this.settingRepository})
      : super(
          const StateTheme(isDarkTheme: false, locale: Locale('th')),
        );
  SettingRepository settingRepository = SettingRepository();
  void setTheme(String themeName) {
    bool themeState = settingRepository.setNewTheme(themeName);
    emit(StateTheme(isDarkTheme: themeState, locale: state.locale));
  }

  void setLocale(Locale localeLanguages) {
    Locale states = settingRepository.setNewLocale(localeLanguages);
    print(settingRepository.getTheme());
    emit(StateTheme(locale: states, isDarkTheme: state.isDarkTheme));
  }
}
