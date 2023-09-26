
import 'package:flutter/material.dart';
import 'package:sip_app/modules/auth/widgets/signup_email_input.dart';
import 'package:sip_app/modules/auth/widgets/signup_email_next_button.dart';
import 'package:sip_app/modules/auth/widgets/signup_password_input.dart';
import 'package:sip_app/modules/auth/widgets/signup_progress_bar_widget.dart';
import 'package:sip_app/modules/auth/widgets/signup_submit_button.dart';
import 'package:sip_app/modules/auth/widgets/signup_title_widget.dart';

class SignupPasswordView extends StatelessWidget {
  SignupPasswordView();

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          SignupProgressbar(step: 4),
          SizedBox(height: 40),
          SignupTitle(title: '비밀번호를 입력해주세요.', step: 4,),
          SignupPasswordInput(),
          SizedBox(height: 40),
          SignupSubmitButton(),
        ],
      ),
    );
  }
}