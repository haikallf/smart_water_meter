import 'package:http/http.dart' as http;
import 'dart:convert';
import "dart:io" show Platform;

import 'package:smart_water_meter/models/device_model.dart';

class DevicesDummyController {
  var client = http.Client();
  // var ip = "192.168.100.4";

  String baseUrl = "http://192.168.100.4:3000";

  Future<dynamic> getAllDevices() async {
    var url = Uri.parse("$baseUrl/all_pools");
    var _headers = {'Content-Type': 'application/json'};
    // var _body = json.encode({
    //   "email": email,
    //   "password": password,
    // });

    var response = await client.get(url, headers: _headers);
    var devices = jsonDecode(response.body);
    return devices["devices"];
  }

  Future<dynamic> getAllAbnormalSensors() async {
    var url = Uri.parse("$baseUrl/all_pools_predictions_only");
    var _headers = {'Content-Type': 'application/json'};

    var response = await client.get(url, headers: _headers);
    var devices = jsonDecode(response.body);
    return devices["devices"];
  }

  Future<dynamic> getSensorDetailsById(String id) async {
    var url = Uri.parse("$baseUrl/get_pool_details_by_id/$id");
    var _headers = {'Content-Type': 'application/json'};

    var response = await client.get(url, headers: _headers);
    return DeviceModel.fromJson(jsonDecode(response.body));
  }
}
