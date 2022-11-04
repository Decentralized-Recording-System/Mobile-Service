import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/logic/index.dart';
import '/widgets/index.dart';

enum LanguagesCharacter { en, th }

class CLanguagesRadio extends StatefulWidget {
  const CLanguagesRadio({Key? key}) : super(key: key);

  @override
  State<CLanguagesRadio> createState() => _CLanguagesRadioState();
}

class _CLanguagesRadioState extends State<CLanguagesRadio> {
  LanguagesCharacter? _languages = LanguagesCharacter.th;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubitCubit, StateTheme>(
        builder: (context, state) {
      if (state is StateTheme) {
        String languageState = state.locale.toString();
        if (languageState == 'th') {
          _languages = LanguagesCharacter.th;
        } else {
          _languages = LanguagesCharacter.en;
        }
        return Column(
          children: [
            RadioListTile<LanguagesCharacter>(
              title: const Text('Thai'),
              value: LanguagesCharacter.th,
              groupValue: _languages,
              onChanged: (LanguagesCharacter? value) {
                setState(() {
                  _languages = value;
                  context
                      .read<SettingCubitCubit>()
                      .setLocale(const Locale('th'));
                });
              },
            ),
            RadioListTile<LanguagesCharacter>(
              title: const Text('English'),
              value: LanguagesCharacter.en,
              groupValue: _languages,
              onChanged: (LanguagesCharacter? value) {
                setState(() {
                  _languages = value;
                  context
                      .read<SettingCubitCubit>()
                      .setLocale(const Locale('en'));
                });
              },
            ),
          ],
        );
      } else {
        return CircularProgressIndicator();
      }
    });
  }
}
