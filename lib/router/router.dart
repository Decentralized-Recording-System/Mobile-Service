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
    Books.id: (context) => const Books(),
    VerifyEmailScreen.id: (context) => const VerifyEmailScreen(),
    PassCode.id: (context) => const PassCode(),
    PassCodeSetting.id: (context) => const PassCodeSetting(),
    Splash.id: (context) => const Splash(),
    SetTheme.id: (context) => const SetTheme(),
    SetLanguages.id: (context) => const SetLanguages(),
  };
}
