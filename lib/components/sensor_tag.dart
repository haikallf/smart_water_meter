import 'package:flutter/material.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/sensor_status.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:tuple/tuple.dart';

class SensorTag extends StatefulWidget {
  const SensorTag({super.key, required this.sensorStatus});
  final String sensorStatus; // baik, cukup, buruk --> enums/sensor_status.dart

  @override
  State<SensorTag> createState() => _SensorTagState();
}

class _SensorTagState extends State<SensorTag> {
  Tuple3<Color, Color, String> getSensorTag() {
    switch (widget.sensorStatus) {
      case SensorStatus.baik:
        return const Tuple3<Color, Color, String>(
            (ColorConstant.colorssuccess), (Colors.black), "Baik");
      case SensorStatus.cukup:
        return const Tuple3<Color, Color, String>(
            (ColorConstant.colorswarningcontainer),
            (ColorConstant.colorswarning),
            "Cukup");
      case SensorStatus.buruk:
        return const Tuple3<Color, Color, String>((ColorConstant.colorsdanger),
            (ColorConstant.colorsdanger), "Buruk");
      default:
        return const Tuple3<Color, Color, String>(
            (Colors.black), (Colors.black), "null");
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
        Text(
          getSensorTag().item3,
          style: const TextStyleConstant()
              .body03
              .copyWith(color: getSensorTag().item2),
        )
      ],
    );
  }
}
