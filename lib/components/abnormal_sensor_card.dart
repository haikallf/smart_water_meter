import 'package:flutter/material.dart';
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
              Icon(Icons.wifi_tethering),
              SizedBox(
                width: 8,
              ),
              Text(
                "Sensor Kolam A-1",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          RichText(
              text: TextSpan(
                  text: "",
                  style: DefaultTextStyle.of(context).style,
                  children: [
                TextSpan(
                    text: "2",
                    style:
                        TextStyle(fontSize: 31, fontWeight: FontWeight.w700)),
                TextSpan(text: " Sensor", style: TextStyle(fontSize: 13))
              ])),
          Text(
            "Tidak Normal",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          )
        ]),
      ),
    );
  }
}
