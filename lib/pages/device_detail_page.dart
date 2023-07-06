import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/components/sensor_parameter_card.dart';
import 'package:smart_water_meter/controllers/devices-dummy.dart';
import 'package:smart_water_meter/enums/parameter_status.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:smart_water_meter/models/device_model1.dart';
import 'package:web_socket_channel/io.dart';

class DeviceDetailPage extends StatefulWidget {
  const DeviceDetailPage({super.key, required this.deviceId});
  final String deviceId;

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  // final channel = IOWebSocketChannel.connect("ws://10.0.2.2:8000/ws");

  String btcUsdtPrice = "0";

  DeviceModel1 device = DeviceModel1();

  @override
  void initState() {
    super.initState();
    loadData();
    // streamListener();
    // channel.sink.add("64981d179e96fce4ddb7b2ef");
  }

  void loadData() async {
    final detailsTemp =
        await DevicesDummyController().getSensorDetailsById(widget.deviceId);
    setState(() {
      device = detailsTemp;
    });
  }

  // streamListener() {
  //   channel.stream.listen((message) {
  //     // channel.sink.close();
  //     // Map getData = jsonDecode(message);
  //     print(message);

  //     // setState(() {
  //     //   btcUsdtPrice = getData["value"];
  //     // });

  //     // print(btcUsdtPrice);
  //   });
  // }

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
                device.name ?? "NULL",
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
                            parameterValue:
                                device.current?["temp"]?.sensorValue ?? "--",
                            parameterUnit: " ℃",
                            parameterStatus:
                                device.current?["temp"]?.condition !=
                                        ParameterStatus.normal
                                    ? ParameterStatus.warning
                                    : ParameterStatus.normal,
                            parameterRecommendation:
                                device.current?["temp"]?.recommendation ??
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
                            parameterName: "Oksigen",
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
                          parameterValue:
                              device.current?["ph"]?.sensorValue ?? "--",
                          parameterUnit: " ℃",
                          parameterStatus: device.current?["ph"]?.condition !=
                                  ParameterStatus.normal
                              ? ParameterStatus.warning
                              : ParameterStatus.normal,
                          parameterRecommendation:
                              device.current?["ph"]?.recommendation ?? "Normal",
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
