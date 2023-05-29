import 'package:flutter/material.dart';

class SensorCard extends StatefulWidget {
  const SensorCard({super.key});

  @override
  State<SensorCard> createState() => _SensorCardState();
}

class _SensorCardState extends State<SensorCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 12, left: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.yellow,
                  size: 10,
                ),
                SizedBox(
                  width: 4,
                ),
                Text("Butuh Pengecekan")
              ],
            ),
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
    );
  }
}
