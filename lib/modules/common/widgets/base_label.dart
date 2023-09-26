import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';

class BaseLabel extends StatelessWidget {
  final String label;

  BaseLabel({required this.label});

  Widget build(BuildContext context) {
    return Text(
        label,
        style: TextStyle(
            color: BLACK_COLOR_FONT,
            fontSize: 14,
            fontWeight: FontWeight.w500
        ));
  }
}