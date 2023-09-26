import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';

class BaseBottomButton extends StatelessWidget {
  final String label;
  final Function onClickButton;

  BaseBottomButton({required this.label, required this.onClickButton});

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClickButton();
      },
      child: Container(
      height: 54,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: NAVIGATION_TEXT_COLOR,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Text(label,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700)),
    ));
  }
}