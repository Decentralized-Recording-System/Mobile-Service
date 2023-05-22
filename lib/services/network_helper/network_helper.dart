import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../constants/index.dart';

class NetworkHelper {
  Future postDataAPI(String module, dynamic data) async {
    var url = Uri.https("drs-service.onrender.com", 'users/$module');
    print(url);
    http.Response response =
        await http.post(url, body: data, headers: ApiConstants.headerApi);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future postDataAPIwithAccessToken(
      String module, dynamic data, String accessToken) async {
    var url = Uri.https("drs-service.onrender.com", 'users/$module');

    http.Response response = await http.post(
      url,
      body: data,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future postDataAPIwithAccessTokenWithOutUser(
      String module, dynamic data, String accessToken) async {
    var url = Uri.https("drs-service.onrender.com", module);

    http.Response response = await http.post(
      url,
      body: data,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future getDataAPI(String module) async {
    var url = Uri.https("drs-service.onrender.com", 'users/$module');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getDataAPIWithHeader(String module, String accessToken) async {
    print(accessToken);
    var url = Uri.https("drs-service.onrender.com", 'users/$module');
    http.Response response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
      return [];
    }
  }

  Future getDataAPIWithHeaderNoUser(String module, String accessToken) async {
    var url = Uri.https("drs-service.onrender.com", module);
    print(url);
    http.Response response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
