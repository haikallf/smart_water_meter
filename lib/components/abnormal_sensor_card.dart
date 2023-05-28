import 'package:flutter/material.dart';

class AbnormalSensorCard extends StatefulWidget {
  const AbnormalSensorCard({super.key});

  @override
  State<AbnormalSensorCard> createState() => _AbnormalSensorCardState();
}

class _AbnormalSensorCardState extends State<AbnormalSensorCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 265,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text("Image"),
            Text(
              "Sensor Kolam A-1",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        RichText(
            text: TextSpan(
                text: "",
                style: DefaultTextStyle.of(context).style,
                children: [
              TextSpan(
                  text: "2",
                  style: TextStyle(fontSize: 31, fontWeight: FontWeight.w700)),
              TextSpan(text: " Sensor", style: TextStyle(fontSize: 13))
            ])),
        Text(
          "Tidak Normal",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        )
      ]),
    );
  }
}
