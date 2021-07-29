import 'package:flutter/material.dart';

class CustomAppBar {
  static AppBar buildWhiteAppBar({String? title, List<Widget>? actions}) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      brightness: Brightness.light,
      title: Text(
        title ?? '',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      leadingWidth: 34,
      actions: actions ?? [],
    );
  }
}
