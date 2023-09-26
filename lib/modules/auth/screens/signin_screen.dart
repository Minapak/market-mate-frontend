import 'package:flutter/material.dart';
import 'package:sip_app/modules/auth/widgets/signin_handler.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/auth/widgets/signin_view.dart';
import 'package:sip_app/modules/common/widgets/main_bottom_navigationbar.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultLayout(
          child: SigninView(),
          backgroundColor: Colors.white,
        ),
        SigninHandler(),
      ],
    );
  }
}
