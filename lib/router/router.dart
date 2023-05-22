import 'package:flutter/material.dart';
import '../screens/contracts/contracts.dart';
import '../screens/index.dart';
import '../screens/model_history/model_detail_history.dart';
import '../screens/model_history/model_history.dart';
import '../screens/my_contract/list_contract.dart';
import '../screens/my_contract/mycontract.dart';
import '../screens/register/register_detail.dart';
import '../widgets/register/register_detail.dart';

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
    RealTime.id: (context) => const RealTime(),
    TelemeticsTransaction.id: (context) => const TelemeticsTransaction(),
    UserProfile.id: (context) => const UserProfile(),
    RegisterDetailPage.id: (context) => const RegisterDetailPage(),
    ModelHistory.id: (context) => const ModelHistory(),
    ModelDetailHistory.id: (context) => const ModelDetailHistory(),
    Contract.id: (context) => const Contract(),
    MyContract.id: (context) => const MyContract(),
    MyDetailContract.id: (context) => const MyDetailContract(),
  };
}
