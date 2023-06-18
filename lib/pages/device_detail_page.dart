import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/components/sensor_parameter_card.dart';
import 'package:smart_water_meter/enums/parameter_status.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:web_socket_channel/io.dart';

class DeviceDetailPage extends StatefulWidget {
  const DeviceDetailPage({super.key});

  @override
  State<DeviceDetailPage> createState() => _DeviceDetailPageState();
}

class _DeviceDetailPageState extends State<DeviceDetailPage> {
  final channel =
      IOWebSocketChannel.connect("wss://socketsbay.com/wss/v2/1/demo/");

  String btcUsdtPrice = "0";

  @override
  void initState() {
    super.initState();

    // streamListener();
  }

  streamListener() {
    channel.stream.listen((message) {
      // channel.sink.add("received data");
      // channel.sink.close();
      Map getData = jsonDecode(message);

      setState(() {
        btcUsdtPrice = getData["value"];
      });

      print(btcUsdtPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const iconoir.NavArrowLeft()),
      ),
      backgroundColor: Colors.white,
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
                "Sensor Kolam A-2",
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
                            parameterValue: btcUsdtPrice,
                            parameterUnit: " ℃",
                            parameterStatus: ParameterStatus.warning,
                            parameterRecommendation: "Turunkan suhu air",
                            parameterBackground: "temp",
                            parameterValuePrediction: "30",
                            parameterWarningPrediction: "Suhu Air Tinggi",
                            parameterRecommendationPrediction:
                                "Matikan Heater"),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(
                          parameterName: "Oksigen",
                          parameterValue: "75",
                          parameterUnit: " %",
                          parameterStatus: ParameterStatus.abnormal,
                          parameterRecommendation: "",
                          parameterBackground: "do",
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(
                          parameterName: "Amonia",
                          parameterValue: "50",
                          parameterUnit: " mg/mL",
                          parameterStatus: ParameterStatus.warning,
                          parameterRecommendation: "Tambahkan 10g/mL",
                          parameterBackground: "ammonia",
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SensorParameterCard(
                          parameterName: "pH Air",
                          parameterValue: "6.5",
                          parameterUnit: " pH",
                          parameterStatus: ParameterStatus.normal,
                          parameterRecommendation: "",
                          parameterBackground: "ph",
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(
                          parameterName: "Kekeruhan",
                          parameterValue: "999",
                          parameterUnit: " NTU",
                          parameterStatus: ParameterStatus.warning,
                          parameterRecommendation: "Lakukan koagulasi",
                          parameterBackground: "turbidity",
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(
                          parameterName: "Salinitas",
                          parameterValue: "30.2",
                          parameterUnit: " %",
                          parameterStatus: ParameterStatus.normal,
                          parameterRecommendation: "",
                          parameterBackground: "salinity",
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