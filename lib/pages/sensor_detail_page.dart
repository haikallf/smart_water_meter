import 'package:flutter/material.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 16),
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
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(120),
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Baik",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      )
                    ])),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SensorParameterCard(),
                        SizedBox(
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
                        SizedBox(
                          height: 14,
                        ),
                        SensorParameterCard(),
                        SizedBox(
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
