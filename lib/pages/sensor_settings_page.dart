import 'package:flutter/material.dart';
import 'package:smart_water_meter/components/custom_list_view.dart';
import 'package:tuple/tuple.dart';

class SensorSettingsPage extends StatefulWidget {
  const SensorSettingsPage({super.key});

  @override
  State<SensorSettingsPage> createState() => _SensorSettingsPageState();
}

class _SensorSettingsPageState extends State<SensorSettingsPage> {
  @override
  Widget build(BuildContext context) {
    List<Tuple2<String, VoidCallback?>> sensorList = [
      Tuple2<String, VoidCallback?>("Sensor Kolam A-1", () {}),
      Tuple2<String, VoidCallback?>("Sensor Kolam A-2", () {}),
      Tuple2<String, VoidCallback?>("Sensor Kolam A-3", () {}),
      Tuple2<String, VoidCallback?>("Sensor Kolam B-1", () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SensorSettingsPage()));
      }),
    ];

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Pengaturan Alat",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      )),
      backgroundColor: const Color(0xFFF4F4F4),
      body: SafeArea(child: CustomListView(listItems: sensorList)),
    );
  }
}
