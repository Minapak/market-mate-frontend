
import 'package:flutter/material.dart';
import 'package:sip_app/modules/auth/widgets/signup_input_widget.dart';
import 'package:sip_app/modules/auth/widgets/signup_name_input.dart';
import 'package:sip_app/modules/auth/widgets/signup_name_next_button.dart';
import 'package:sip_app/modules/auth/widgets/signup_next_button_widget.dart';
import 'package:sip_app/modules/auth/widgets/signup_progress_bar_widget.dart';
import 'package:sip_app/modules/auth/widgets/signup_title_widget.dart';

class SignupNameView extends StatelessWidget {
  SignupNameView();

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          SignupProgressbar(step: 1),
          SizedBox(height: 40),
          SignupTitle(title: '이름을 입력해주세요.', step:1),
          SignupNameInput(),
          SizedBox(height: 40),
          SignupNameNextButton(),
        ],
      ),
    );
  }
}
