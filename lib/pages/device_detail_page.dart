import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/components/sensor_parameter_card.dart';
import 'package:smart_water_meter/controllers/devices-dummy.dart';
import 'package:smart_water_meter/controllers/devices.dart';
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
                            parameterRecommendation: checkAnomalyParameterValue(
                                        currentAnomalies, "temperature")
                                    ?.action ??
                                "Normal",
                            parameterValuePrediction:
                                device.predictions?["temp"]?.sensorValue,
                            parameterWarningPrediction:
                                device.predictions?["temp"]?.condition,
                            parameterRecommendationPrediction:
                                device.predictions?["temp"]?.recommendation),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(
                            parameterName: "Oksigen Terlarut",
                            parameterBackground: "do",
                            parameterValue:
                                device.current?["do"]?.sensorValue ?? "--",
                            parameterUnit: " ℃",
                            parameterStatus: device.current?["do"]?.condition !=
                                    ParameterStatus.normal
                                ? ParameterStatus.warning
                                : ParameterStatus.normal,
                            parameterRecommendation:
                                device.current?["do"]?.recommendation ??
                                    "Normal",
                            parameterValuePrediction:
                                device.predictions?["do"]?.sensorValue,
                            parameterWarningPrediction:
                                device.predictions?["do"]?.condition,
                            parameterRecommendationPrediction:
                                device.predictions?["do"]?.recommendation),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(
                            parameterName: "Amonia",
                            parameterBackground: "ammonia",
                            parameterValue:
                                device.current?["ammonia"]?.sensorValue ?? "--",
                            parameterUnit: " ℃",
                            parameterStatus:
                                device.current?["ammonia"]?.condition !=
                                        ParameterStatus.normal
                                    ? ParameterStatus.warning
                                    : ParameterStatus.normal,
                            parameterRecommendation:
                                device.current?["ammonia"]?.recommendation ??
                                    "Normal",
                            parameterValuePrediction:
                                device.predictions?["ammonia"]?.sensorValue,
                            parameterWarningPrediction:
                                device.predictions?["ammonia"]?.condition,
                            parameterRecommendationPrediction:
                                device.predictions?["ammonia"]?.recommendation),
                      ],
                    ),
                    Column(
                      children: [
                        SensorParameterCard(
                          parameterName: "pH Air",
                          parameterBackground: "ph",
                          parameterValue: deviceDetails.ph ?? "--",
                          parameterUnit: " pH",
                          parameterStatus:
                              checkAnomalyParameter(currentAnomalies, "ph")
                                  ? ParameterStatus.warning
                                  : ParameterStatus.normal,
                          parameterRecommendation:
                              checkAnomalyParameterValue(currentAnomalies, "ph")
                                      ?.action ??
                                  "Normal",
                          parameterValuePrediction:
                              device.predictions?["ph"]?.sensorValue,
                          parameterWarningPrediction:
                              device.predictions?["ph"]?.condition,
                          parameterRecommendationPrediction:
                              device.predictions?["ph"]?.recommendation,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(
                          parameterName: "Kekeruhan",
                          parameterBackground: "turbidity",
                          parameterValue:
                              device.current?["turbidity"]?.sensorValue ?? "--",
                          parameterUnit: " ℃",
                          parameterStatus:
                              device.current?["turbidity"]?.condition !=
                                      ParameterStatus.normal
                                  ? ParameterStatus.warning
                                  : ParameterStatus.normal,
                          parameterRecommendation:
                              device.current?["turbidity"]?.recommendation ??
                                  "Normal",
                          parameterValuePrediction:
                              device.predictions?["turbidity"]?.sensorValue,
                          parameterWarningPrediction:
                              device.predictions?["turbidity"]?.condition,
                          parameterRecommendationPrediction:
                              device.predictions?["turbidity"]?.recommendation,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(
                          parameterName: "Salinitas",
                          parameterBackground: "salinity",
                          parameterValue:
                              device.current?["salinity"]?.sensorValue ?? "--",
                          parameterUnit: " ℃",
                          parameterStatus:
                              device.current?["salinity"]?.condition !=
                                      ParameterStatus.normal
                                  ? ParameterStatus.warning
                                  : ParameterStatus.normal,
                          parameterRecommendation:
                              device.current?["salinity"]?.recommendation ??
                                  "Normal",
                          parameterValuePrediction:
                              device.predictions?["salinity"]?.sensorValue,
                          parameterWarningPrediction:
                              device.predictions?["salinity"]?.condition,
                          parameterRecommendationPrediction:
                              device.predictions?["salinity"]?.recommendation,
                        ),
                      ],
                    )
                  ]),
            )
          ],
        ),
      )),
    );
  }
}
