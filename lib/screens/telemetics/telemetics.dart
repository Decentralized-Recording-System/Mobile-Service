import 'package:flutter/material.dart';

class Telemetics extends StatefulWidget {
  const Telemetics({super.key});
  static const String id = 'Telemetics';
  @override
  State<Telemetics> createState() => _TelemeticsState();
}

class _TelemeticsState extends State<Telemetics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Telemetics'),
    ));
  }
}
