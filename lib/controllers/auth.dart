import 'package:http/http.dart' as http;
import 'dart:convert';
import "dart:io" show Platform;

import 'package:smart_water_meter/models/user_response_model.dart';

class AuthController {
  var client = http.Client();

  String baseUrl =
      Platform.isAndroid ? "http://10.0.2.2:8000" : "http://localhost:8000";

  Future<UserResponseModel> signIn(String email, String password) async {
    var url = Uri.parse("$baseUrl/user/login");
    var _headers = {'Content-Type': 'application/json'};
    var _body = json.encode({
      "email": email,
      "password": password,
    });

    var response = await client.post(url, headers: _headers, body: _body);
    print(response.statusCode);
    return UserResponseModel.fromJson(
        jsonDecode(response.body), response.statusCode);
  }
}
