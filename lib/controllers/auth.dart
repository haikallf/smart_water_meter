import 'dart:io';

import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:smart_water_meter/enums/global_config.dart';
import 'dart:convert';

import 'package:smart_water_meter/models/user_response_model.dart';
import 'package:smart_water_meter/utils/local_storage.dart';

class AuthController {
  var client = http.Client();

  String baseUrl = GlobalConfig.baseUrl;

  Future<UserResponseModel> signIn(String email, String password) async {
    var url = Uri.parse("$baseUrl/user/login");
    var _headers = {'Content-Type': 'application/json'};
    var device_id = LocalStorage.getDeviceToken();
    print("device_id: $device_id");
    var _body = json
        .encode({"email": email, "password": password, "device_id": device_id});

    var response = await client.post(url, headers: _headers, body: _body);
    print(response.body);
    return UserResponseModel.fromJson(
        jsonDecode(response.body), response.statusCode);
  }

  Future triggerNotif() async {
    var url = Uri.parse("$baseUrl/haikalfadil@email.com");
    var _headers = {'Content-Type': 'application/json'};

    await client.post(url, headers: _headers, body: {});
  }

  Future<UserResponseModel> changeName(String name) async {
    var url = Uri.parse("$baseUrl/user/change-name");
    dynamic token = await SessionManager().get("token");
    // var _headers = {'Content-Type': 'application/json'};
    var _headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };
    var _body = json.encode({"name": name});

    var response = await client.put(url, headers: _headers, body: _body);

    print(response.body);
    return UserResponseModel.fromJson(
        jsonDecode(response.body), response.statusCode);
  }
}
