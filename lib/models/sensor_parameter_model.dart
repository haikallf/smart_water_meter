class SensorParameterModel {
  String? name;
  ParameterDetailsModel? parameterDetails;

  SensorParameterModel({this.name, this.parameterDetails});

  factory SensorParameterModel.fromJson(Map<String, dynamic> responseBody) {
    return SensorParameterModel(
      name: responseBody['name'],
      parameterDetails:
          ParameterDetailsModel.fromJson(responseBody[responseBody['name']]),
    );
  }
}

class ParameterDetailsModel {
  String? sensorValue;
  String? condition;
  String? recommendation;

  ParameterDetailsModel(
      {this.sensorValue, this.condition, this.recommendation});

  factory ParameterDetailsModel.fromJson(Map<String, dynamic>? responseBody) {
    return ParameterDetailsModel(
      sensorValue: responseBody?['sensor_value'].toString(),
      condition: responseBody?['condition'],
      recommendation: responseBody?['recommendation'],
    );
  }
}
