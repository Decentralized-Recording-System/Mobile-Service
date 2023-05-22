import 'dart:async';
import '../../../model/index.dart';
import '../../index.dart';

class UserService {
  Future<String> checkAccessToken(String accessToken) async {
    NetworkHelper networkHelper = NetworkHelper();
    final objectJsonDecode =
        await networkHelper.getDataAPIWithHeader('access', accessToken);
    return objectJsonDecode;
  }

  Future<Users> getProfile(String accessToken) async {
    try {
      NetworkHelper networkHelper = NetworkHelper();
      final objectJsonDecode =
          await networkHelper.getDataAPIWithHeader('user', accessToken);
      print(objectJsonDecode);
      Users resources = Users.fromJson(objectJsonDecode['data']);
      return resources;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
