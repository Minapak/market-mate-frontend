import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';

class FixedBottomMultiButton extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;

  const FixedBottomMultiButton(
      {required this.leftLabel, required this.rightLabel, Key? key})
      : super();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 0,
        child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            width: double.infinity,
            height: 74,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: PRIMARY_DARK_BUTTON_COLOR,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(leftLabel,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        ))),
                SizedBox(width: 12),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: NAVIGATION_TEXT_COLOR,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(rightLabel,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        )))
              ],
            )));
  }
}
