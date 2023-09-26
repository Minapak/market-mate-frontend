
import 'package:flutter/material.dart';
import 'package:sip_app/modules/auth/widgets/signup_phone_input.dart';
import 'package:sip_app/modules/auth/widgets/signup_phone_next_button.dart';
import 'package:sip_app/modules/auth/widgets/signup_progress_bar_widget.dart';
import 'package:sip_app/modules/auth/widgets/signup_title_widget.dart';

class SignupPhoneView extends StatelessWidget {
  SignupPhoneView();

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          SignupProgressbar(step: 3),
          SizedBox(height: 40),
          SignupTitle(title: '휴대폰번호를 입력해주세요.', step:3),
          SignupPhoneInput(),
          SizedBox(height: 40),
          SignupPhoneNextButton(),
        ],
      ),
    );
  }
}
