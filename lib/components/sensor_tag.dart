import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class SensorTag extends StatefulWidget {
  const SensorTag({super.key, required this.status});
  final String status; // baik, cukup, buruk

  @override
  State<SensorTag> createState() => _SensorTagState();
}

class _SensorTagState extends State<SensorTag> {
  Tuple2<Color, String> getSensorTag() {
    switch (widget.status) {
      case "baik":
        return const Tuple2<Color, String>((Colors.green), "Baik");
      case "cukup":
        return const Tuple2<Color, String>((Colors.yellow), "Cukup");
      case "buruk":
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
