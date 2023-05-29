import 'package:flutter/material.dart';
import 'package:smart_water_meter/components/sensor_tag.dart';

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
        padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black)),
        child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SensorTag(status: "baik"),
                  Text(
                    "Sensor Kolam A-1",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  )
                ],
              ),
              // TODO: CHANGE ICON
              Icon(
                Icons.chevron_right,
                size: 32,
              )
            ]),
      ),
    );
  }
}
