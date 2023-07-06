import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smart_water_meter/models/device_model1.dart';

class DevicesDummyController {
  var client = http.Client();
  // var ip = "192.168.100.4";

  String baseUrl = "http://127.0.0.1:3000";

  Future<dynamic> getAllDevices() async {
    var url = Uri.parse("$baseUrl/all_pools");
    var _headers = {'Content-Type': 'application/json'};

    var response = await client.get(url, headers: _headers);
    return jsonDecode(response.body);
  }

  Future<dynamic> getAllAbnormalSensors() async {
    var url = Uri.parse("$baseUrl/all_pools_predictions_only");
    var _headers = {'Content-Type': 'application/json'};

    var response = await client.get(url, headers: _headers);
    return jsonDecode(response.body);
  }

  Future<dynamic> getSensorDetailsById(String id) async {
    var url = Uri.parse("$baseUrl/get_pool_details_by_id/$id");
    var _headers = {'Content-Type': 'application/json'};

    var response = await client.get(url, headers: _headers);
    return DeviceModel1.fromJson(jsonDecode(response.body));
  }

  Future<dynamic> updateDeviceNameById(String id, String newName) async {
    var url = Uri.parse("$baseUrl/all_pools/$id");
    var url2 = Uri.parse("$baseUrl/all_pools_predictions_only/$id");
    var url3 = Uri.parse("$baseUrl/get_pool_details_by_id/$id");

    var _headers = {'Content-Type': 'application/json'};
    var _body = jsonEncode({"name": newName});

    var response = await client.patch(url, headers: _headers, body: _body);
    if (response.statusCode == 200) {
      response = await client.patch(url2, headers: _headers, body: _body);
      if (response.statusCode == 200) {
        response = await client.patch(url3, headers: _headers, body: _body);
      }
    }
    return response.statusCode;
  }

  Future<dynamic> deleteDeviceNameById(String id) async {
    var url = Uri.parse("$baseUrl/all_pools/$id");
    var url2 = Uri.parse("$baseUrl/all_pools_predictions_only/$id");
    var url3 = Uri.parse("$baseUrl/get_pool_details_by_id/$id");

    var _headers = {'Content-Type': 'application/json'};

    var response = await client.delete(url, headers: _headers);
    if (response.statusCode == 200) {
      response = await client.delete(url2, headers: _headers);
      if (response.statusCode == 200) {
        response = await client.delete(url3, headers: _headers);
      }
    }
    return response.statusCode;
  }
}
