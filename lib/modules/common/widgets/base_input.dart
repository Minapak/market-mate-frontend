import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';

class BaseInput extends StatelessWidget {
  final String? hintText;
  final bool? isObscure;
  final ValueChanged<String> onChangeValue;

  BaseInput({this.hintText, this.isObscure, required this.onChangeValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: INPUT_BORDER_GRAY_COLOR),
      ),
      child: TextField(
        obscureText: isObscure ?? false,
        maxLines: 1,
        minLines: 1,
        onChanged: onChangeValue,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.all(10), // Padding inside the TextField
        ),
      ),
    );
  }
}