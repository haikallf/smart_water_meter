import 'package:smart_water_meter/models/sensor_parameter_model.dart';

class DeviceModel {
  String? id;
  String? name;
  Map<String, ParameterDetailsModel?>? current;
  Map<String, ParameterDetailsModel?>? predictions;

  DeviceModel({this.id, this.name, this.current, this.predictions});

  factory DeviceModel.fromJson(Map<String, dynamic> responseBody) {
    return DeviceModel(
        id: responseBody['id'],
        name: responseBody['name'],
        current: {
          "temp":
              ParameterDetailsModel.fromJson(responseBody["current"]["temp"]),
          "do": ParameterDetailsModel.fromJson(responseBody["current"]["do"]),
          "ammonia": ParameterDetailsModel.fromJson(
              responseBody["current"]["ammonia"]),
          "ph": ParameterDetailsModel.fromJson(responseBody["current"]["ph"]),
          "turbidity": ParameterDetailsModel.fromJson(
              responseBody["current"]["turbidity"]),
          "salinity": ParameterDetailsModel.fromJson(
              responseBody["current"]["salinity"])
        },
        predictions: {
          "temp": ParameterDetailsModel.fromJson(
              responseBody["predictions"]["temp"]),
          "do":
              ParameterDetailsModel.fromJson(responseBody["predictions"]["do"]),
          "ammonia": ParameterDetailsModel.fromJson(
              responseBody["predictions"]["ammonia"]),
          "ph":
              ParameterDetailsModel.fromJson(responseBody["predictions"]["ph"]),
          "turbidity": ParameterDetailsModel.fromJson(
              responseBody["predictions"]["turbidity"]),
          "salinity": ParameterDetailsModel.fromJson(
              responseBody["predictions"]["salinity"])
        });
  }
}
