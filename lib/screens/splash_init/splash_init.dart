import 'package:flutter/material.dart';

import '../../services/index.dart';
import '../index.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static const String id = 'Splash';
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late LoginStatusDatabase loginStatusDatabase;
  @override
  void initState() {
    loginStatusDatabase = LoginStatusDatabase.instance;
    loginStatusDatabase.readData(1).then((value) => {
          // ignore: unrelated_type_equality_checks
          if (value.loginStatus == "true")
            {
              setState(() {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, PassCode.id);
                });
              })
            }
          else
            {
              setState(() {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, Login.id);
                });
              })
            }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
