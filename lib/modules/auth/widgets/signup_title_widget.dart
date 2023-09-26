
import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';

class SignupTitle extends StatelessWidget {
  final String title;
  final int step;

  SignupTitle({required this.title, required this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Q$step.', style: TextStyle(
            color: BLACK_COLOR_FONT,
            fontSize: 30,
            fontWeight: FontWeight.w700
        ),),
        SizedBox(height: 20),
        Text(title, style: TextStyle(
            color: BLACK_COLOR_FONT,
            fontSize: 18,
            fontWeight: FontWeight.w500
        ),),
        SizedBox(height: 40),
      ],
    );
  }
}