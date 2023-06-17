import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';
import 'package:smart_water_meter/pages/device_detail_page.dart';

class AbnormalSensorCard extends StatefulWidget {
  const AbnormalSensorCard(
      {super.key, required this.sensorName, required this.sensorCount});
  final String sensorName;
  final String sensorCount;

  @override
  State<AbnormalSensorCard> createState() => _AbnormalSensorCardState();
}

class _AbnormalSensorCardState extends State<AbnormalSensorCard> {
  @override
  Widget build(BuildContext context) {
    void goToDetailPage() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DeviceDetailPage()));
    }

    return GestureDetector(
      onTap: goToDetailPage,
      child: Container(
        width: 265,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ColorConstant.colorsVariant90,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                      color: ColorConstant.colorsprimary,
                      borderRadius: BorderRadius.circular(1000)),
                  child: SvgPicture.asset(
                    "assets/wifi.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  )),
              const SizedBox(
                width: 8,
              ),
              Text(
                widget.sensorName,
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
                TextSpan(
                    text: widget.sensorCount,
                    style: const TextStyleConstant().heading02),
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
