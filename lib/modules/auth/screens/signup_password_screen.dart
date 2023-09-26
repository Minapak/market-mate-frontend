import 'package:flutter/material.dart';
import 'package:sip_app/modules/auth/widgets/signup_password_view.dart';
import 'package:sip_app/modules/auth/widgets/signup_submit_handler.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';

class SignupPasswordScreen extends StatelessWidget {
  const SignupPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultLayout(
          appBar: BackAppBar(title: ''),
          child: SignupPasswordView(),
          backgroundColor: Colors.white,
        ),
        SignupSubmitHandler(),
      ],
    );
  }
}
