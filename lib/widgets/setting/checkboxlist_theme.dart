import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/logic/index.dart';
import '/widgets/index.dart';

enum ThemeCharacter { light, dark }

class CThemeRadio extends StatefulWidget {
  const CThemeRadio({Key? key}) : super(key: key);

  @override
  State<CThemeRadio> createState() => _CThemeRadioState();
}

class _CThemeRadioState extends State<CThemeRadio> {
  ThemeCharacter? theme = ThemeCharacter.light;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubitCubit, StateTheme>(
        builder: (context, state) {
      if (state is StateTheme) {
        theme = ThemeCharacter.light;
        if (state.isDarkTheme) {
          theme = ThemeCharacter.dark;
        } else {}
        return Column(
          children: [
            RadioListTile<ThemeCharacter>(
              title: const Text('dark mode'),
              value: ThemeCharacter.light,
              groupValue: theme,
              onChanged: (ThemeCharacter? value) {
                setState(() {
                  theme = value;
                  context.read<SettingCubitCubit>().setTheme("dark");
                });
              },
            ),
            RadioListTile<ThemeCharacter>(
              title: const Text('light mode'),
              value: ThemeCharacter.dark,
              groupValue: theme,
              onChanged: (ThemeCharacter? value) {
                setState(() {
                  theme = value;
                  context.read<SettingCubitCubit>().setTheme("light");
                });
              },
            ),
          ],
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}
