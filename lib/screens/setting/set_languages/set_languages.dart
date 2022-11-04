import 'package:flutter/material.dart';

import '../../../widgets/index.dart';

class SetLanguages extends StatefulWidget {
  const SetLanguages({super.key});
  static const String id = 'SetLanguages';
  @override
  State<SetLanguages> createState() => _SetLanguagesState();
}

class _SetLanguagesState extends State<SetLanguages> {
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo')),
      body: ListView(children: const [CLanguagesRadio()]),
    );
  }
}
