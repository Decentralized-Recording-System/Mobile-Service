import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telemetics/model/api/index.dart';
import 'package:telemetics/widgets/register/register_detail.dart';

import '../../logic/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';
import '../index.dart';

class RegisterDetailPage extends StatefulWidget {
  const RegisterDetailPage({super.key});
  static const String id = 'RegisterDetailPage';
  @override
  State<RegisterDetailPage> createState() => _RegisterDetailPageState();
}

class _RegisterDetailPageState extends State<RegisterDetailPage> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var email = arg['email'];
    var name = arg['name'];
    var lastName = arg['lastName'];
    var password = arg['password'];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            RegisterDetail(
              email: email,
              name: name,
              lastName: lastName,
              password: password,
            ),
            //// Loading(),
            // Text(args[0].toString())
          ],
        ),
      ),
    );
  }
}
