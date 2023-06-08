import 'package:flutter/material.dart';
import 'package:iconoir_flutter/iconoir_flutter.dart';
import 'package:smart_water_meter/enums/color_constant.dart';
import 'package:smart_water_meter/enums/text_style_constant.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.formFocusHandler});

  final Function(String) controller;
  final String hintText;
  final Function(bool) formFocusHandler;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;
  bool isFormFocus = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Focus(
        onFocusChange: (isFocus) {
          setState(() {
            widget.formFocusHandler(isFocus);
            isFormFocus = isFocus;
          });
        },
        child: TextField(
          onChanged: (value) {
            widget.controller(value.toString());
          },
          obscureText: _obscureText,
          style: const TextStyleConstant().body02,
          decoration: InputDecoration(
              prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: KeyAltBack(
                    color: isFormFocus
                        ? ColorConstant.colorsprimary
                        : Colors.black,
                  )),
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: _obscureText
                        ? EyeEmpty(
                            color: isFormFocus
                                ? ColorConstant.colorsprimary
                                : Colors.black,
                          )
                        : EyeOff(
                            color: isFormFocus
                                ? ColorConstant.colorsprimary
                                : Colors.black,
                          ),
                  )),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConstant.colorsNeutral50)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: ColorConstant.colorsprimary)),
              hintText: widget.hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12)),
        ),
      ),
    );
  }
}
