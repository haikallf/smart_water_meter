import 'package:flutter/material.dart';

class CustomSnackBar {
  SnackBar showSnackBar(String text) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(20),
      action: SnackBarAction(
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
