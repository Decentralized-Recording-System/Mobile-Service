import 'package:flutter/material.dart';

import '../../constants/variable/variable.dart';
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
              color: Colors.greenAccent,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text(
              "Account",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
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
          title: settingTitleList[0],
          icon: settingIconList[0],
        ),
        SettingOption(
          title: settingTitleList[1],
          icon: settingIconList[1],
        ),
        SettingOption(
          title: settingTitleList[2],
          icon: settingIconList[2],
        )
      ]),
    ));
  }
}
