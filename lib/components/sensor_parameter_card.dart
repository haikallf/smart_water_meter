import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart' as iconoir;
import 'package:smart_water_meter/components/warning_fade_icon.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
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
      required this.parameterBackground,
      this.parameterValuePrediction,
      this.parameterWarningPrediction,
      this.parameterRecommendationPrediction});

  final String parameterName;
  final String parameterValue;
  final String parameterUnit;
  final String
      parameterStatus; // normal, warning, abnormal --> enums/parameter_status.dart
  final String? parameterRecommendation;
  final String parameterBackground;
  final String? parameterValuePrediction;
  final String? parameterWarningPrediction;
  final String? parameterRecommendationPrediction;

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
      case ParameterStatus.normal:
        return Tuple3<Color, Color, AssetImage>(
            (ColorConstant.colorsonsecondarycontainer),
            (ColorConstant.colorsNeutral50),
            AssetImage('assets/param-${widget.parameterBackground}.png'));
      default:
        return Tuple3<Color, Color, AssetImage>(
            (ColorConstant.colorsNeutral50),
            (ColorConstant.colorsNeutral50),
            AssetImage('assets/param-${widget.parameterBackground}.png'));
    }
  }

  @override
  Widget build(BuildContext context) {
    void sensorPredictionModalBottomSheet(BuildContext context) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Wrap(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(children: [
                        // // MARK: Sheet Indicator
                        // Container(
                        //   height: 6,
                        //   width: 180,
                        //   margin: const EdgeInsets.symmetric(vertical: 12),
                        //   decoration: BoxDecoration(
                        //       color: ColorConstant.colorsNeutral80,
                        //       borderRadius: BorderRadius.circular(120)),
                        // ),

                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Color(0x1A000000)))),
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const iconoir.Cancel()),
                              const SizedBox(
                                width: 8,
                              ),
                              Text("Prediksi 15 Menit ke Depan",
                                  style: const TextStyleConstant().title03),
                            ],
                          ),
                        ),
                        // MARK: Sheet Contents
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "",
                                      style: DefaultTextStyle.of(context).style,
                                      children: [
                                    TextSpan(
                                        text: widget.parameterValuePrediction,
                                        style: const TextStyleConstant()
                                            .heading01
                                            .copyWith(
                                                color: ColorConstant
                                                    .colorswarning)),
                                    TextSpan(
                                        text: widget.parameterUnit,
                                        style: const TextStyleConstant()
                                            .heading04
                                            .copyWith(
                                                color: ColorConstant
                                                    .colorsNeutral60))
                                  ])),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                widget.parameterName,
                                style: const TextStyleConstant().heading04,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                widget.parameterWarningPrediction ?? "",
                                style: const TextStyleConstant().body03,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        "Rekomendasi Aksi",
                                        style:
                                            const TextStyleConstant().title03,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        widget.parameterRecommendationPrediction ??
                                            "",
                                        style: const TextStyleConstant()
                                            .paragraph03
                                            .copyWith(
                                                color: ColorConstant
                                                    .colorsVariant20),
                                      ),
                                      const SizedBox(
                                        height: 57,
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              );
            });
          });
    }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.parameterName,
                        style: const TextStyleConstant().title03,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.parameterStatus == ParameterStatus.normal
                            ? "Normal"
                            : widget.parameterRecommendation ?? "null",
                        style: const TextStyleConstant().body03.copyWith(
                            color: getParameterColorAndBackground().item2),
                        // softWrap: true,
                        // overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                if (widget.parameterValuePrediction != null &&
                    widget.parameterRecommendationPrediction != null)
                  WarningFadeIcon(
                    onTap: () {
                      sensorPredictionModalBottomSheet(context);
                    },
                  )
              ],
            ),
            RichText(
                text: TextSpan(
                    text: "",
                    style: DefaultTextStyle.of(context).style,
                    children: [
                  TextSpan(
                      text: widget.parameterStatus == ParameterStatus.abnormal
                          ? "--"
                          : widget.parameterValue,
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
