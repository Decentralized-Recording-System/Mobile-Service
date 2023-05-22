import 'dart:async';
import 'dart:convert';

import '../../../model/index.dart';
import '../../index.dart';

class VerifyService {
  Future<bool> verifyEmail(VerifyEmail user) async {
    try {
      var params = jsonEncode(user.toJson());
      print(params);
      NetworkHelper networkHelper = NetworkHelper();
      final data = await networkHelper.postDataAPI('activate', params);
      print(data);
      if (data != null) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<String> resetVerifyEmail() async {
    NetworkHelper networkHelper = NetworkHelper();
    final objectJsonDecode = await networkHelper.getDataAPI('activate');
    return objectJsonDecode;
  }
}
