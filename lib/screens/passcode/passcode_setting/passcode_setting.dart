import 'package:flutter/material.dart';

import '../../../widgets/index.dart';

class PassCodeSetting extends StatefulWidget {
  const PassCodeSetting({super.key});
  static const String id = 'PassCodeSetting';
  @override
  State<PassCodeSetting> createState() => _PassCodeSettingState();
}

class _PassCodeSettingState extends State<PassCodeSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          const Expanded(
              flex: 2,
              child: Numpad(
                length: 5,
              ))
        ],
      ),
    );
  }
}
