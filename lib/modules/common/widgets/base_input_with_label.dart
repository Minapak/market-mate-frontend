
import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/widgets/base_input.dart';
import 'package:sip_app/modules/common/widgets/base_label.dart';

class BaseInputWithLabel extends StatelessWidget {
  final String label;
  final String? hintText;
  final bool? isObscure;
  final ValueChanged<String> onChangeValue;

  BaseInputWithLabel({
    required this.label,
    required this.onChangeValue,
    this.isObscure,
    this.hintText
  });

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseLabel(label: label),
          SizedBox(height: 10),
          BaseInput(isObscure: isObscure, onChangeValue: onChangeValue, hintText: hintText,),
        ],
      )
    );
  }
}