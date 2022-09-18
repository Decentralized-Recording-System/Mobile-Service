import 'package:flutter/material.dart';
import '../screens/index.dart';

class AppRouter {
  static final routeScreens = <String, WidgetBuilder>{
    Dashboard.id: (context) => const Dashboard(),
    Telemetics.id: (context) => const Telemetics(),
    History.id: (context) => const History(),
    Launcher.id: (context) => const Launcher(),
    Setting.id: (context) => const Setting(),
    Login.id: (context) => const Login(),
    Register.id: (context) => const Register(),
    Telemetics.id: (context) => const Telemetics(),
  };
}
