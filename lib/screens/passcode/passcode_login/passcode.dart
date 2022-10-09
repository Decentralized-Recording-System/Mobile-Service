import 'package:flutter/material.dart';

import '../../../widgets/index.dart';

class PassCode extends StatefulWidget {
  const PassCode({super.key});
  static const String id = 'PassCode';
  @override
  State<PassCode> createState() => _PassCodeState();
}

class _PassCodeState extends State<PassCode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          const Expanded(
              flex: 2,
              child: NumpadLogin(
                length: 5,
              ))
        ],
      ),
    );
  }
}
