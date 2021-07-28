import 'package:flutter/material.dart';

class CustomAppBar {
  static AppBar buildWhiteAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      brightness: Brightness.light,
    );
  }
}
