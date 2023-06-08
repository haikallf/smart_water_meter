import 'package:flutter/material.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/color_constants.dart';
import 'package:smart_water_meter/enums/parameter_status.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:tuple/tuple.dart';

class SensorParameterCard extends StatefulWidget {
  const SensorParameterCard(
      {super.key,
      required this.parameterName,
      required this.parameterValue,
      required this.parameterUnit,
      required this.parameterStatus,
      this.parameterRecommendation,
      required this.parameterBackground});

  final String parameterName;
  final String parameterValue;
  final String parameterUnit;
  final String
      parameterStatus; // normal, warning, danger --> enums/parameter_status.dart
  final String? parameterRecommendation;
  final String parameterBackground;

  @override
  State<SensorParameterCard> createState() => _SensorParameterCardState();
}

class _SensorParameterCardState extends State<SensorParameterCard> {
  Tuple3<Color, Color, AssetImage> getParameterColorAndBackground() {
    switch (widget.parameterStatus) {
      case ParameterStatus.warning:
        return const Tuple3<Color, Color, AssetImage>(
            (ColorConstant.colorsonwarningcontainer),
            (ColorConstant.colorsWarning60),
            AssetImage('assets/param-warning.png'));
      case ParameterStatus.danger:
        return const Tuple3<Color, Color, AssetImage>(
            (ColorConstant.colorsondangercontainer),
            (ColorConstant.colorsDanger70),
            AssetImage('assets/param-danger.png'));
      default:
        return Tuple3<Color, Color, AssetImage>(
            (ColorConstant.colorsonsecondarycontainer),
            (ColorConstant.colorsNeutral50),
            AssetImage('assets/param-${widget.parameterBackground}.png'));
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
          // border: Border.all(color: getParameterColorAndBackground().item1),
          image: DecorationImage(
              image: getParameterColorAndBackground().item3,
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
                  style: const TextStyleConstant().title03,
                ),
                Text(
                  widget.parameterStatus == ParameterStatus.normal
                      ? "Normal"
                      : widget.parameterRecommendation ?? "null",
                  style: const TextStyleConstant()
                      .body03
                      .copyWith(color: getParameterColorAndBackground().item2),
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
                      style: const TextStyleConstant().heading01.copyWith(
                          color: getParameterColorAndBackground().item1)),
                  TextSpan(
                      text: widget.parameterUnit,
                      style: const TextStyleConstant().heading04.copyWith(
                          color: getParameterColorAndBackground().item2))
                ])),
          ]),
    );
  }
}
