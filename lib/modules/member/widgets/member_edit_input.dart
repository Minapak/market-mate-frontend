import 'package:flutter/material.dart';

class MemberEditInput extends StatelessWidget {
  final String label;
  final String value;
  final Function(String) onChange;
  MemberEditInput(
      {required this.label, required this.value, required this.onChange});

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          initialValue: value,
          onChanged: onChange,
        ),
      ],
    );
  }
}
