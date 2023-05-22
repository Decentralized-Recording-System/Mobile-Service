part of 'setting_cubit_cubit.dart';

@immutable
abstract class SettingCubitState {
  const SettingCubitState();

  List<Object> get props => [];
}

class SettingCubitInitial extends SettingCubitState {}

class StateLanguages extends SettingCubitState {
  final Locale locale;
  const StateLanguages({required this.locale});
  @override
  List<Object> get props => [locale];
}

class StateTheme extends SettingCubitState {
  final bool isDarkTheme;
  final Locale locale;
  const StateTheme({required this.isDarkTheme, required this.locale});
  @override
  List<Object> get props => [isDarkTheme, locale];
}
