import 'package:flutter/material.dart';

class ActiveDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function onClickYes;

  ActiveDialog({required this.title, required this.message, required this.onClickYes});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
       Row(
         children: [
           TextButton(
             child: Text('아니요'),
             onPressed: () => Navigator.of(context).pop(),
           ),
           TextButton(
             child: Text('네'),
             onPressed: () {
               onClickYes();
               Navigator.of(context).pop();
             },
           ),
         ],
       )
      ],
    );
  }

  static void showActive(
      BuildContext context,
      {required String title, required String message, required Function onClickYes}) {
    showDialog(
      context: context,
      builder: (ctx) => ActiveDialog(title: title, message: message, onClickYes: onClickYes),
    );
  }
}