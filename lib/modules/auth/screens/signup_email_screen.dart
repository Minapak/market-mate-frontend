import 'package:flutter/material.dart';
import 'package:sip_app/modules/auth/widgets/signup_email_handler.dart';
import 'package:sip_app/modules/auth/widgets/signup_email_view.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/common/widgets/home_appbar.dart';
class SignupEmailScreen extends StatelessWidget {
  const SignupEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultLayout(
          appBar: HomeAppBar(title: ''),
          child: SignupEmailView(),
          backgroundColor: Colors.white,
        ),
        SignupEmailHandler(),
      ],
    );
  }
}
