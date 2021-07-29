import 'package:flutter/material.dart';

class SnackbarUtils {
  static showMessage({required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
