import 'package:flutter/material.dart';
import 'package:smart_water_meter/enums/color_constant.dart';

class CustomButton extends StatefulWidget {
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.isDisabled = false,
      this.backgroundColor = ColorConstant.colorsprimary});

  final Function()? onTap;
  final String text;
  final bool isDisabled;
  final Color backgroundColor;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onTap,
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(widget.isDisabled
              ? ColorConstant.colorsNeutral80
              : widget.backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ))),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
