import 'package:smart_water_meter/models/device_model.dart';
import 'package:smart_water_meter/models/user_model.dart';

class DeviceResponseModel {
  List<DeviceModel>? devices;
  int responseStatusCode;

  DeviceResponseModel({this.devices, required this.responseStatusCode});

  factory DeviceResponseModel.fromJson(
      List<dynamic> responseBody, int responseStatusCode) {
    List<DeviceModel>? deviceModels =
        responseBody.map((json) => DeviceModel.fromJson(json)).toList();

    return DeviceResponseModel(
        devices: deviceModels, responseStatusCode: responseStatusCode);
  }
}
