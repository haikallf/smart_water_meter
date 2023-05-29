import 'package:flutter/material.dart';
import 'package:smart_water_meter/enums/sensor_status.dart';
import 'package:tuple/tuple.dart';

class SensorTag extends StatefulWidget {
  const SensorTag({super.key, required this.sensorStatus});
  final String sensorStatus; // baik, cukup, buruk --> enums/sensor_status.dart

  @override
  State<SensorTag> createState() => _SensorTagState();
}

class _SensorTagState extends State<SensorTag> {
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
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: getSensorTag().item1,
          size: 10,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(getSensorTag().item2)
      ],
    );
  }
}
