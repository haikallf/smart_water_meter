import 'package:flutter/material.dart';
import 'package:smart_water_meter/components/sensor_detail_tag.dart';
import 'package:smart_water_meter/components/sensor_parameter_card.dart';

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
                      SensorDetailTag(status: "buruk")
                    ])),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SensorParameterCard(),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(),
                        SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(),
                      ],
                    ),
                    Column(
                      children: [
                        SensorParameterCard(),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(),
                        const SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(),
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
