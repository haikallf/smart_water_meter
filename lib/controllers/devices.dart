import 'dart:io';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:smart_water_meter/enums/global_config.dart';
import 'package:smart_water_meter/models/device_response_model.dart';
import 'dart:convert';

class DevicesController {
  var client = http.Client();

  String baseUrl = GlobalConfig.baseUrl;

  Future<DeviceResponseModel> getAllDevices() async {
    var url = Uri.parse("$baseUrl/pool/");
    dynamic token = await SessionManager().get("token");
    print(token);

    var _headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var response = await client.get(
      url,
      headers: _headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return DeviceResponseModel.fromJson(
          jsonDecode(response.body), response.statusCode);
    } else {
      return DeviceResponseModel.fromJson([], response.statusCode);
    }
  }

  Future<int> changeDeviceNameById(String deviceId, String name) async {
    var url = Uri.parse("$baseUrl/pool/$deviceId/change-name");
    dynamic token = await SessionManager().get("token");
    print(token);

    var _headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var _body = json.encode({"name": name});

    var response = await client.put(url, headers: _headers, body: _body);

    print(response.body);
    return response.statusCode;
  }

  Future<int> addNewPool(String deviceId, String name) async {
    var url = Uri.parse("$baseUrl/pool/add");
    dynamic token = await SessionManager().get("token");
    print(token);

    var _headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var _body = json.encode({"id": deviceId, "name": name});

    var response = await client.post(url, headers: _headers, body: _body);

    print(response.body);
    return response.statusCode;
  }

  Future<int> deletePoolById(String deviceId) async {
    var url = Uri.parse("$baseUrl/pool/$deviceId/delete");
    dynamic token = await SessionManager().get("token");
    print(token);

    var _headers = {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var response = await client.delete(url, headers: _headers);

    print(response.body);
    return response.statusCode;
  }

  Future<int> setPoolToNormalById(String deviceId) async {
    var url = Uri.parse("$baseUrl/pool/$deviceId/set-normal");
    dynamic token = await SessionManager().get("token");
    print(token);

    var _headers = {
      HttpHeaders.acceptHeader: "application/json",
      // HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var _body = json.encode({});

    var response = await client.put(url, headers: _headers, body: _body);

    print(response.body);
    return response.statusCode;
  }
}
