class DeviceModel {
  String? id;
  String? name;
  String? status;
  List<AnomalyModel> anomalies;

  DeviceModel({this.id, this.name, this.status, required this.anomalies});

  factory DeviceModel.fromJson(Map<String, dynamic> responseBody) {
    return DeviceModel(
      id: responseBody['id'],
      name: responseBody['name'],
      status: responseBody['status'],
      anomalies: (responseBody['anomaly'] as List<dynamic>)
          .map((json) => AnomalyModel.fromJson(json))
          .toList(),
    );
  }
}

class AnomalyModel {
  String sensorType;
  String action;

  AnomalyModel({required this.sensorType, required this.action});

  factory AnomalyModel.fromJson(Map<String, dynamic> responseBody) {
    return AnomalyModel(
      sensorType: responseBody['sensorType'],
      action: responseBody['action'],
    );
  }
}
