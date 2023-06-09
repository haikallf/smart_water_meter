import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';

class DeviceCard extends StatefulWidget {
  const DeviceCard({super.key, required this.sensorName, required this.onTap});
  final String sensorName;
  final VoidCallback? onTap;

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorConstant.colorsNeutral80)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            widget.sensorName,
            style: const TextStyleConstant().heading04,
          ),
          const iconoir.NavArrowRight()
        ]),
      ),
    );
  }
}
