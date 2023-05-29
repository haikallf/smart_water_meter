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
          children: [Text("Sensor Kolam A-2"), Text("Normal")],
        ),
      )),
    );
  }
}
