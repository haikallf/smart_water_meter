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
    var url = Uri.parse("$baseUrl/pool");
    dynamic token = await SessionManager().get("token");
    print(token);

    var _headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    };

    var response = await client.get(
      url,
      headers: _headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      return DeviceResponseModel.fromJson(jsonDecode(response.body));
    } else {
      return DeviceResponseModel();
    }
  }
}
