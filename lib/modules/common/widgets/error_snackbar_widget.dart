import 'package:flutter/material.dart';

class ErrorSnackbar extends StatelessWidget {
  final String message;
  final VoidCallback? onClosed;

  ErrorSnackbar({required this.message, this.onClosed});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              if (onClosed != null) {
                onClosed!();
              }
            },
          ),
        ),
      );
    });
    return Container();
  }
}