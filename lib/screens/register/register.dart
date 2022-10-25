import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telemetics/model/api/index.dart';

import '../../logic/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';
import '../index.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static const String id = 'Register';
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: const [
          RegisterColumn(),
          Loading(),
        ],
      ),
    );
  }
}
