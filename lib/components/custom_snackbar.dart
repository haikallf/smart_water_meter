import 'package:flutter/material.dart';

class CustomSnackBar {
  SnackBar showSnackBar(String text) {
    final snackBar = SnackBar(
      backgroundColor: const Color(0xFF6C6C6C),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
      action: SnackBarAction(
        textColor: Colors.white,
        label: "Tutup",
        onPressed: () {},
      ),
      content: Text(text),
      // backgroundColor: Colors.teal,
    );
    return snackBar;
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
