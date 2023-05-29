import 'package:flutter/material.dart';
import 'package:smart_water_meter/enums/color_constants.dart';
import 'package:smart_water_meter/enums/parameter_status.dart';
import 'package:tuple/tuple.dart';

class SensorParameterCard extends StatefulWidget {
  const SensorParameterCard(
      {super.key,
      required this.parameterName,
      required this.parameterValue,
      required this.parameterUnit,
      required this.parameterStatus,
      this.parameterRecommendation});

  final String parameterName;
  final String parameterValue;
  final String parameterUnit;
  final String
      parameterStatus; // normal, warning, danger --> enums/parameter_status.dart
  final String? parameterRecommendation;

  @override
  State<SensorParameterCard> createState() => _SensorParameterCardState();
}

class _SensorParameterCardState extends State<SensorParameterCard> {
  Tuple2<Color, AssetImage> getParameterColorAndBackground() {
    switch (widget.parameterStatus) {
      case ParameterStatus.warning:
        return const Tuple2<Color, AssetImage>((ColorConstants.warningYellow),
            AssetImage('assets/warning-parameter.jpeg'));
      case ParameterStatus.danger:
        return const Tuple2<Color, AssetImage>((ColorConstants.dangerRed),
            AssetImage('assets/danger-parameter.jpeg'));
      default:
        return const Tuple2<Color, AssetImage>(
            (Colors.black), AssetImage('assets/normal-parameter.jpeg'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      width: 172,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 17),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: getParameterColorAndBackground().item1),
          image: DecorationImage(
              image: getParameterColorAndBackground().item2,
              fit: BoxFit.cover)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.parameterName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text(
                  widget.parameterStatus == ParameterStatus.normal
                      ? "Normal"
                      : widget.parameterRecommendation ?? "null",
                  style: TextStyle(
                      color: widget.parameterStatus == ParameterStatus.normal
                          ? ColorConstants.gray
                          : getParameterColorAndBackground().item1),
                )
              ],
            ),
            RichText(
                text: TextSpan(
                    text: "",
                    style: DefaultTextStyle.of(context).style,
                    children: [
                  TextSpan(
                      text: widget.parameterValue,
                      style: TextStyle(
                          fontSize: 39,
                          fontWeight: FontWeight.w700,
                          color: getParameterColorAndBackground().item1)),
                  TextSpan(
                      text: widget.parameterUnit,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.gray))
                ])),
          ]),
    );
  }
}
