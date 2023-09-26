import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;

  ErrorDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          child: Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  static void showError(BuildContext context, {required String title, required String message}) {
    showDialog(
      context: context,
      builder: (ctx) => ErrorDialog(title: title, message: message),
    );
  }
}