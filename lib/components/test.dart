import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floating Snackbar'),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content: Text('This is a floating snackbar'),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('Show Snackbar'),
            ),
          ),
          Positioned(
            bottom: 16, // Adjust the value to control the snackbar position
            left: 16,
            right: 16,
            child: SafeArea(
              child: SnackBar(
                content: Text('This is a floating snackbar'),
                behavior: SnackBarBehavior.floating,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
