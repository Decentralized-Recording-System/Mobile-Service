import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telemetics/screens/index.dart';

import '../../constants/i18n/index.dart';
import '../../constants/variable/setting/variable.dart';
import '../../logic/index.dart';
import '../../widgets/index.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});
  static const String id = 'Setting';
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Row(
          children: [
            Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text(
              AppLocalizations.of(context)!.translate('Account'),
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        Divider(
          height: 20,
          thickness: 1,
        ),
        SizedBox(
          height: 10,
        ),
        SettingOption(
          title: AppLocalizations.of(context)!.translate('Profile'),
          icon: settingIconList[0],
          onTaped: () {
            Navigator.pushNamed(context, UserProfile.id);
          },
        ),
        SettingOption(
          title: AppLocalizations.of(context)!.translate('Languages'),
          icon: settingIconList[1],
          onTaped: () {
            Navigator.pushNamed(context, SetLanguages.id);
          },
        ),
        SettingOption(
          title: AppLocalizations.of(context)!.translate('Theme'),
          icon: settingIconList[2],
          onTaped: () {
            Navigator.pushNamed(context, SetTheme.id);
          },
        ),
        SettingOption(
          title: AppLocalizations.of(context)!.translate('Logout'),
          icon: settingIconList[3],
          onTaped: () {
            context.read<LoginCubitCubit>().funcLogout();
            Navigator.pushReplacementNamed(context, PassCode.id);
          },
        )
      ]),
    ));
  }
}
