import 'package:flutter/material.dart';

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
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Normal",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      )
                    ]))
          ],
        ),
      )),
    );
  }
}
