import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  const CustomSnackBar({super.key, required super.content});

  Widget showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(20),
      content: content,
      // backgroundColor: Colors.teal,
    );
    return snackBar;
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

// class CustomSnackBar extends SnackBar {
//   const CustomSnackBar(
//       {super.key, required this.context, required super.content});
//   final BuildContext context;

//   void showCustomSnackBar() {
//     final snackBar = SnackBar(
//       content: Text('Hi, Flutter developers'),
//       backgroundColor: Colors.teal,
//     );
//     // return snackBar;
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
