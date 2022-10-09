import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../constants/index.dart';

class NetworkHelper {
  Future postDataAPI(String module, dynamic data) async {
    var url = Uri.http("10.0.2.2:5000", 'users/$module');
    http.Response response =
        await http.post(url, body: data, headers: ApiConstants.headerApi);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getDataAPI(String module) async {
    var url = Uri.http("10.0.2.2:5000", 'users/$module');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getDataAPIWithHeader(String module, String accessToken) async {
    var url = Uri.http("10.0.2.2:5000", 'users/$module');
    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
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
