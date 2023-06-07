import 'package:flutter/material.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:smart_water_meter/pages/sensor_detail_page.dart';

class AbnormalSensorCard extends StatefulWidget {
  const AbnormalSensorCard({super.key});

  @override
  State<AbnormalSensorCard> createState() => _AbnormalSensorCardState();
}

class _AbnormalSensorCardState extends State<AbnormalSensorCard> {
  @override
  Widget build(BuildContext context) {
    void goToDetailPage() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SensorDetailPage()));
    }

    return GestureDetector(
      onTap: goToDetailPage,
      child: Container(
        width: 265,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(1000)),
                  child: const Image(
                      image: AssetImage(
                    "assets/sensor-icon.png",
                  ))),
              // Icon(Icons.wifi_tethering),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Sensor Kolam A-1",
                style: const TextStyleConstant().heading06,
              )
            ],
          ),
          const SizedBox(
            height: 27,
          ),
          RichText(
              text: TextSpan(
                  text: "",
                  style: DefaultTextStyle.of(context).style,
                  children: [
                TextSpan(text: "2", style: const TextStyleConstant().heading02),
                TextSpan(
                    text: " Sensor", style: const TextStyleConstant().body03)
              ])),
          Text(
            "Tidak Normal",
            style: const TextStyleConstant().heading05,
          )
        ]),
      ),
    );
  }
}
