import 'package:flutter/material.dart';
import 'package:smart_water_meter/enums/sensor_status.dart';
import 'package:tuple/tuple.dart';

class SensorDetailTag extends StatefulWidget {
  const SensorDetailTag({super.key, required this.sensorStatus});
  final String sensorStatus; // baik, cukup, buruk --> enums/sensor_status.dart

  @override
  State<SensorDetailTag> createState() => _SensorDetailTagState();
}

class _SensorDetailTagState extends State<SensorDetailTag> {
  Tuple2<Color, String> getSensorTag() {
    switch (widget.sensorStatus) {
      case SensorStatus.baik:
        return const Tuple2<Color, String>((Colors.green), "Baik");
      case SensorStatus.cukup:
        return const Tuple2<Color, String>((Colors.yellow), "Cukup");
      case SensorStatus.buruk:
        return const Tuple2<Color, String>((Colors.red), "Buruk");
      default:
        return const Tuple2<Color, String>((Colors.black), "null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(120),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            size: 10,
            color: getSensorTag().item1,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            getSensorTag().item2,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
