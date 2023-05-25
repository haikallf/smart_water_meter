import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.prefixIcon,
    required this.formFocusHandler,
  });

  final Function(String) controller;
  final String hintText;
  final bool obscureText;
  final Icon? prefixIcon;
  final Function(bool) formFocusHandler;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Focus(
        onFocusChange: (isFocus) {
          setState(() {
            widget.formFocusHandler(isFocus);
          });
        },
        child: TextField(
          onChanged: (value) {
            widget.controller(value.toString());
          },
          obscureText: widget.obscureText,
          decoration: InputDecoration(
              prefixIcon: widget.prefixIcon ?? const Icon(null),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)),
              fillColor: Colors.grey[100],
              filled: true,
              hintText: widget.hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12)),
        ),
      ),
    );
  }
}
