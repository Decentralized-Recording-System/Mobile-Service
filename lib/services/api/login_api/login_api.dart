import 'dart:async';
import 'dart:convert';

import '../../../model/index.dart';
import '../../index.dart';

class LoginService {
  Future<String> signIn(SignIn user) async {
    try {
      var params = jsonEncode(user.toJson());
      NetworkHelper networkHelper = NetworkHelper();
      final responseStatus = await networkHelper.postDataAPI('login', params);
      // print(responseStatus['accessToken']);
      return responseStatus['accessToken'];
    } catch (e) {
      return 'failed';
    }
  }

  Future<bool> signUp(SignUp user) async {
    try {
      var params = jsonEncode(user.toJson());
      NetworkHelper networkHelper = NetworkHelper();
      await networkHelper.postDataAPI('register', params);

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
