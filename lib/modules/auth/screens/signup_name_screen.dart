import 'package:flutter/material.dart';
import 'package:sip_app/modules/auth/widgets/signup_name_view.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';

class SignupNameScreen extends StatelessWidget {
  const SignupNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackAppBar(title: ''),
      child: SignupNameView(),
      backgroundColor: Colors.white,
    );
  }
}
