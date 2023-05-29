import 'package:flutter/material.dart';
import 'package:smart_water_meter/components/sensor_detail_tag.dart';
import 'package:smart_water_meter/components/sensor_parameter_card.dart';
import 'package:smart_water_meter/enums/parameter_status.dart';
import 'package:smart_water_meter/enums/sensor_status.dart';

class SensorDetailPage extends StatefulWidget {
  const SensorDetailPage({super.key});

  @override
  State<SensorDetailPage> createState() => _SensorDetailPageState();
}

class _SensorDetailPageState extends State<SensorDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: []),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // MARK: Sensor Detail Heading
            Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sensor Kolam A-2",
                        style: TextStyle(
                            fontSize: 31, fontWeight: FontWeight.w700),
                      ),

                      // MARK: Sensor Quality Tag
                      SensorDetailTag(sensorStatus: SensorStatus.buruk)
                    ])),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SensorParameterCard(
                          parameterName: "Suhu Air",
                          parameterValue: "28",
                          parameterUnit: " ℃",
                          parameterStatus: ParameterStatus.warning,
                          parameterRecommendation: "Turunkan suhu air",
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(
                          parameterName: "Oksigen",
                          parameterValue: "75",
                          parameterUnit: " %",
                          parameterStatus: ParameterStatus.normal,
                          parameterRecommendation: "",
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(
                          parameterName: "Amonia",
                          parameterValue: "50",
                          parameterUnit: " mg/mL",
                          parameterStatus: ParameterStatus.warning,
                          parameterRecommendation: "Tambahkan 10g/mL",
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
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(
                          parameterName: "Kekeruhan",
                          parameterValue: "999",
                          parameterUnit: " NTU",
                          parameterStatus: ParameterStatus.danger,
                          parameterRecommendation: "Lakukan koagulasi",
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
