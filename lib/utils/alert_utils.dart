import 'package:flutter/material.dart';

class AlertUtils {
  static void showDefaultAlert({
    required BuildContext context,
    required String title,
    required String message,
    required String acceptButtonText,
    required VoidCallback onAccept,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(acceptButtonText),
              onPressed: onAccept,
            ),
          ],
        );
      },
    );
  }
}
