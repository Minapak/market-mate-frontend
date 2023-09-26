import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';

class FixedBottomButton extends StatelessWidget {
  final String label;

  const FixedBottomButton({required this.label, Key? key}) : super();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 0,
        child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            width: double.infinity,
            height: 74,
            child: GestureDetector(
                onTap: () {},
                child: Container(
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
                ))));
  }
}
