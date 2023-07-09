import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/components/custom_button.dart';
import 'package:smart_water_meter/components/sensor_parameter_card.dart';
import 'package:smart_water_meter/controllers/devices-dummy.dart';
import 'package:smart_water_meter/controllers/devices.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/parameter_status.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:smart_water_meter/models/device_detail_model.dart';
import 'package:smart_water_meter/models/device_model.dart';
import 'package:smart_water_meter/models/device_model1.dart';
import 'package:web_socket_channel/io.dart';

class DeviceDetailPage extends StatefulWidget {
  const DeviceDetailPage(
      {super.key, required this.deviceId, required this.deviceName});
  final String deviceId;
  final String deviceName;

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  final channel = IOWebSocketChannel.connect(
      "ws://smartwater-be-cjuo2jvqkq-et.a.run.app/ws");

  // String btcUsdtPrice = "0";

  DeviceModel1 device = DeviceModel1();

  DeviceDetailModel deviceDetails = DeviceDetailModel();
  List<DeviceModel> devices = [];

  List<DeviceModel> anomalyDevices = [];
  List<AnomalyModel> anomalies = [];

  List<AnomalyModel> currentAnomalies = [];
  List<AnomalyModel> futureAnomalies = [];

  @override
  void initState() {
    super.initState();
    // loadData();
    streamListener();
  }

  bool checkAnomalyParameter(List<AnomalyModel> anomalyArr, String sensorType) {
    for (var e in anomalyArr) {
      if (sensorType == e.sensorType) return true;
    }
    return false;
  }

  AnomalyModel? checkAnomalyParameterValue(
      List<AnomalyModel> anomalyArr, String sensorType) {
    for (var e in anomalyArr) {
      if (sensorType == e.sensorType) return e;
    }
    return null;
  }

  streamListener() {
    print("device id: ${widget.deviceId}");
    channel.sink.add(widget.deviceId);
    channel.stream.listen((message) async {
      // channel.sink.close();

      final allDevices = await DevicesController().getAllDevices();

      setState(() {
        devices = allDevices.devices ?? [];
        anomalyDevices =
            devices.where((device) => device.id == widget.deviceId).toList();
        anomalies = anomalyDevices[0].anomalies;
        futureAnomalies = anomalies
            .where((anomaly) => anomaly.action.contains("dalam 15 menit"))
            .toList();
        currentAnomalies =
            anomalies.toSet().difference(futureAnomalies.toSet()).toList();
      });

      setState(() {
        deviceDetails = DeviceDetailModel.fromJson(jsonDecode(message));
      });

      print("FUTURE ANOMALIES: ${futureAnomalies[0].sensorType}");
      print("CURRENT ANOMALIES: ${currentAnomalies[0].sensorType}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBFCFE),
        leading: IconButton(
            onPressed: () => Navigator.pop(context, true),
            icon: const iconoir.NavArrowLeft()),
      ),
      backgroundColor: const Color(0xFFFBFCFE),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MARK: Sensor Detail Heading
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  widget.deviceName,
                  style: const TextStyleConstant().heading02,
                ),
              ),
              CustomButton(
                onTap: () {},
                text: "Pengecekan Selesai",
                backgroundColor: Colors.white,
                foregroundColor: ColorConstant.colorsprimary,
                borderColor: ColorConstant.colorsNeutral40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SensorParameterCard(
                              parameterName: "Suhu Air",
                              parameterBackground: "temp",
                              parameterValue: deviceDetails.temperature ?? "--",
                              parameterUnit: " ℃",
                              parameterStatus: checkAnomalyParameter(
                                      currentAnomalies, "temperature")
                                  ? ParameterStatus.warning
                                  : ParameterStatus.normal,
                              parameterRecommendation:
                                  checkAnomalyParameterValue(
                                              currentAnomalies, "temperature")
                                          ?.action ??
                                      "Normal",
                              parameterValuePrediction:
                                  deviceDetails.temperature ?? "--",
                              parameterWarningPrediction: checkAnomalyParameter(
                                      futureAnomalies, "temperature")
                                  ? "Suhu Air Tidak Normal"
                                  : "Suhu Air Normal",
                              parameterRecommendationPrediction:
                                  checkAnomalyParameterValue(
                                          futureAnomalies, "temperature")
                                      ?.action),
                          const SizedBox(
                            height: 14,
                          ),
                          SensorParameterCard(
                              parameterName: "Oksigen Terlarut",
                              parameterBackground: "do",
                              parameterValue:
                                  deviceDetails.dissolvedOxygen ?? "--",
                              parameterUnit: " mg/L",
                              parameterStatus:
                                  checkAnomalyParameter(currentAnomalies, "do")
                                      ? ParameterStatus.warning
                                      : ParameterStatus.normal,
                              parameterRecommendation:
                                  checkAnomalyParameterValue(
                                              currentAnomalies, "do")
                                          ?.action ??
                                      "Normal",
                              parameterValuePrediction:
                                  deviceDetails.dissolvedOxygen ?? "--",
                              parameterWarningPrediction:
                                  checkAnomalyParameter(futureAnomalies, "do")
                                      ? "Oksigen Terlarut Tidak Normal"
                                      : "Oksigen Terlarut Normal",
                              parameterRecommendationPrediction:
                                  checkAnomalyParameterValue(
                                          futureAnomalies, "do")
                                      ?.action),
                          const SizedBox(
                            height: 14,
                          ),
                          SensorParameterCard(
                              parameterName: "TDS",
                              parameterBackground: "tds",
                              parameterValue: deviceDetails.dissolvedOxygen ??
                                  "--",
                              parameterUnit: "",
                              parameterStatus: checkAnomalyParameter(
                                      currentAnomalies, "tds")
                                  ? ParameterStatus.warning
                                  : ParameterStatus.normal,
                              parameterRecommendation:
                                  checkAnomalyParameterValue(
                                              currentAnomalies, "tds")
                                          ?.action ??
                                      "Normal",
                              parameterValuePrediction:
                                  deviceDetails.tds ?? "--",
                              parameterWarningPrediction:
                                  checkAnomalyParameter(futureAnomalies, "tds")
                                      ? "TDS Tidak Normal"
                                      : "TDS Normal",
                              parameterRecommendationPrediction:
                                  checkAnomalyParameterValue(
                                          futureAnomalies, "tds")
                                      ?.action),
                          const SizedBox(
                            height: 14,
                          ),
                          SensorParameterCard(
                              parameterName: "Tegangan Sel Surya",
                              parameterBackground: "volt_solar",
                              parameterValue: deviceDetails.voltSolar ?? "--",
                              parameterUnit: " Volt",
                              parameterStatus: checkAnomalyParameter(
                                      currentAnomalies, "volt_solar")
                                  ? ParameterStatus.warning
                                  : ParameterStatus.normal,
                              parameterRecommendation:
                                  checkAnomalyParameterValue(
                                              currentAnomalies, "volt_solar")
                                          ?.action ??
                                      "Normal",
                              parameterValuePrediction:
                                  deviceDetails.tds ?? "--",
                              parameterWarningPrediction: checkAnomalyParameter(
                                      futureAnomalies, "volt_solar")
                                  ? "Tegangan Surya Tidak Normal"
                                  : "Tegangan Surya Normal",
                              parameterRecommendationPrediction:
                                  checkAnomalyParameterValue(
                                          futureAnomalies, "volt_solar")
                                      ?.action),
                        ],
                      ),
                      Column(
                        children: [
                          SensorParameterCard(
                              parameterName: "Keasaman Air",
                              parameterBackground: "ph",
                              parameterValue: deviceDetails.ph ?? "--",
                              parameterUnit: "pH",
                              parameterStatus:
                                  checkAnomalyParameter(currentAnomalies, "ph")
                                      ? ParameterStatus.warning
                                      : ParameterStatus.normal,
                              parameterRecommendation:
                                  checkAnomalyParameterValue(
                                              currentAnomalies, "ph")
                                          ?.action ??
                                      "Normal",
                              parameterValuePrediction:
                                  deviceDetails.ph ?? "--",
                              parameterWarningPrediction:
                                  checkAnomalyParameter(futureAnomalies, "ph")
                                      ? "pH Air Tidak Normal"
                                      : "pH Air Normal",
                              parameterRecommendationPrediction:
                                  checkAnomalyParameterValue(
                                          futureAnomalies, "ph")
                                      ?.action),
                          const SizedBox(
                            height: 14,
                          ),
                          SensorParameterCard(
                              parameterName: "Kekeruhan",
                              parameterBackground: "turbidity",
                              parameterValue: deviceDetails.turbidity ?? "--",
                              parameterUnit: "",
                              parameterStatus: checkAnomalyParameter(
                                      currentAnomalies, "turbidity")
                                  ? ParameterStatus.warning
                                  : ParameterStatus.normal,
                              parameterRecommendation:
                                  checkAnomalyParameterValue(
                                              currentAnomalies, "turbidity")
                                          ?.action ??
                                      "Normal",
                              parameterValuePrediction:
                                  deviceDetails.turbidity ?? "--",
                              parameterWarningPrediction: checkAnomalyParameter(
                                      futureAnomalies, "turbidity")
                                  ? "Kekeruhan Tidak Normal"
                                  : "Kekeruhan Normal",
                              parameterRecommendationPrediction:
                                  checkAnomalyParameterValue(
                                          futureAnomalies, "turbidity")
                                      ?.action),
                          const SizedBox(
                            height: 14,
                          ),
                          SensorParameterCard(
                              parameterName: "Suhu Udara",
                              parameterBackground: "temperature_air",
                              parameterValue:
                                  deviceDetails.airTemperature ?? "--",
                              parameterUnit: " ℃",
                              parameterStatus: checkAnomalyParameter(
                                      currentAnomalies, "temperature_air")
                                  ? ParameterStatus.warning
                                  : ParameterStatus.normal,
                              parameterRecommendation:
                                  checkAnomalyParameterValue(currentAnomalies,
                                              "temperature_air")
                                          ?.action ??
                                      "Normal",
                              parameterValuePrediction:
                                  deviceDetails.airTemperature ?? "--",
                              parameterWarningPrediction: checkAnomalyParameter(
                                      futureAnomalies, "temperature_air")
                                  ? "Suhu Udara Tidak Normal"
                                  : "Suhu Udara Normal",
                              parameterRecommendationPrediction:
                                  checkAnomalyParameterValue(
                                          futureAnomalies, "temperature_air")
                                      ?.action),
                          const SizedBox(
                            height: 14,
                          ),
                          SensorParameterCard(
                              parameterName: "Tegangan Baterai",
                              parameterBackground: "volt_battery",
                              parameterValue: deviceDetails.voltBattery ?? "--",
                              parameterUnit: " Volt",
                              parameterStatus: checkAnomalyParameter(
                                      currentAnomalies, "volt_battery")
                                  ? ParameterStatus.warning
                                  : ParameterStatus.normal,
                              parameterRecommendation:
                                  checkAnomalyParameterValue(
                                              currentAnomalies, "volt_battery")
                                          ?.action ??
                                      "Normal",
                              parameterValuePrediction:
                                  deviceDetails.voltBattery ?? "--",
                              parameterWarningPrediction: checkAnomalyParameter(
                                      futureAnomalies, "volt_battery")
                                  ? "Tegangan Baterai Tidak Normal"
                                  : "Tegangan Baterai Normal",
                              parameterRecommendationPrediction:
                                  checkAnomalyParameterValue(
                                          futureAnomalies, "volt_battery")
                                      ?.action),
                        ],
                      )
                    ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}
