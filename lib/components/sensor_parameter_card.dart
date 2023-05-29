import 'package:flutter/material.dart';

class SensorParameterCard extends StatefulWidget {
  const SensorParameterCard({super.key});

  @override
  State<SensorParameterCard> createState() => _SensorParameterCardState();
}

class _SensorParameterCardState extends State<SensorParameterCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      width: 172,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 17),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Suhu Air",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text(
                  "Normal",
                  style: TextStyle(color: Colors.black38),
                )
              ],
            ),
            RichText(
                text: TextSpan(
                    text: "",
                    style: DefaultTextStyle.of(context).style,
                    children: [
                  TextSpan(
                      text: "36",
                      style:
                          TextStyle(fontSize: 39, fontWeight: FontWeight.w700)),
                  TextSpan(
                      text: " ℃",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black38))
                ])),
          ]),
    );
  }
}
