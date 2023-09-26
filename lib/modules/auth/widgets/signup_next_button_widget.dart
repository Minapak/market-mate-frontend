
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/constants/colors.dart';

class SignupNextButton extends StatelessWidget {
  final bool canMoveNextStep;
  final Function onClickButton;

  SignupNextButton({required this.canMoveNextStep, required this.onClickButton});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        onClickButton();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
      children  : [
        Container(
        width: 160,
        height: 54,
        decoration: BoxDecoration(
          color: canMoveNextStep ? BUTTON_PRIMARY_COLOR : INPUT_BORDER_GRAY_COLOR,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('다음', style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700
            ),),
            SizedBox(width: 8),
            SizedBox(
              child: SvgPicture.asset(
                'assets/icons/icon_next_white.svg',
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
      ]
    )
    );
  }
}