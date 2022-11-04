import 'package:flutter/material.dart';

import '../../../widgets/index.dart';

class SetTheme extends StatefulWidget {
  const SetTheme({super.key});
  static const String id = 'SetTheme';
  @override
  State<SetTheme> createState() => _SetThemeState();
}

class _SetThemeState extends State<SetTheme> {
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo')),
      body: ListView(children: const [CThemeRadio()]),
    );
  }
}
