import 'package:telemetics/model/api/index.dart';

import '../services/index.dart';

class LoginRepository {
  late String accessToken = "";
  late Users userProfile;
  VerifyEmail verifyEmail = VerifyEmail();
  bool loginState = false;
  LoginService loginService = LoginService();
  UserService userService = UserService();
  VerifyService verifyService = VerifyService();

  Future<String> login(SignIn user) async {
    accessToken = await loginService.signIn(user);
    if (accessToken != 'failed') {
      loginState = true;
    } else {
      loginState = false;
    }
    return accessToken;
  }

  String getAccessToken() {
    return accessToken;
  }

  bool getLoginState() {
    return loginState;
  }

  Future<bool> requestVerifyEmail(VerifyEmail user) async {
    var verifyStatus = await verifyService.verifyEmail(user);
    return verifyStatus;
  }

  Future<Users> getProfile(String accessToken) async {
    userProfile = await userService.getProfile(accessToken);
    return userProfile;
  }

  String logout() {
    accessToken = "";
    return accessToken;
  }
}
