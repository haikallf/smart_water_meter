import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';

import '../pages/sensor_detail_page.dart';

class SensorCard extends StatefulWidget {
  const SensorCard({super.key});

  @override
  State<SensorCard> createState() => _SensorCardState();
}

class _SensorCardState extends State<SensorCard> {
  @override
  Widget build(BuildContext context) {
    void goToDetailPage() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SensorDetailPage()));
    }

    return GestureDetector(
      onTap: goToDetailPage,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorConstant.colorsNeutral80)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 4,
              ),
              Text(
                "Sensor Kolam A-1",
                style: const TextStyleConstant().heading04,
              )
            ],
          ),
          const iconoir.NavArrowRight()
        ]),
      ),
    );
  }
}
