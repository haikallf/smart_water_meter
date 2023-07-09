class DeviceDetailModel {
  String? temperature;
  String? ph;
  String? dissolvedOxygen;
  String? turbidity;
  String? airTemperature;
  String? humidity;
  String? voltBattery;
  String? voltSolar;
  String? tds;

  DeviceDetailModel(
      {this.temperature,
      this.ph,
      this.dissolvedOxygen,
      this.turbidity,
      this.airTemperature,
      this.humidity,
      this.voltBattery,
      this.voltSolar,
      this.tds});

  factory DeviceDetailModel.fromJson(Map responseBody) {
    return DeviceDetailModel(
      temperature: responseBody['temperature'].toString(),
      ph: responseBody['ph'].toString(),
      dissolvedOxygen: responseBody['do'].toString(),
      turbidity: responseBody['turbidity'].toString(),
      airTemperature: responseBody['temperature_air'].toString(),
      humidity: responseBody['humidity'].toString(),
      voltBattery: responseBody['volt_battery'].toString(),
      voltSolar: responseBody['volt_solar'].toString(),
      tds: responseBody['tds'].toString(),
    );
  }
}
