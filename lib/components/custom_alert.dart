import 'package:flutter/material.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';

class CustomAlert extends StatefulWidget {
  const CustomAlert(
      {super.key,
      this.title,
      required this.content,
      required this.cancelButtonText,
      required this.confirmationButtonText,
      required this.onTap});

  final String? title;
  final String content;
  final String cancelButtonText;
  final String confirmationButtonText;
  final bool isDanger = true;
  final VoidCallback? onTap;

  @override
  State<CustomAlert> createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.content,
              textAlign: TextAlign.center,
              style: const TextStyleConstant().title02,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                SizedBox(
                  width: 158,
                  height: 43,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorConstant.colorsNeutral80),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ))),
                      child: Text(
                        widget.cancelButtonText,
                        style: const TextStyleConstant().label02,
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 158,
                  height: 43,
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context, true);
                        // Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              ColorConstant.colorsdanger),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shadowColor: MaterialStateProperty.all<Color>(
                              Colors.transparent),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: const BorderSide(
                                          color: Colors.black)))),
                      child: Text(
                        widget.confirmationButtonText,
                        style: const TextStyleConstant().label02,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
