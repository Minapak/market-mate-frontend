import 'package:flutter/material.dart';
import 'package:sip_app/modules/auth/widgets/signup_phone_view.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';

import '../widgets/signup_phone_handler.dart';

class SignupPhoneScreen extends StatelessWidget {
  const SignupPhoneScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultLayout(
//       appBar: BackAppBar(title: ''),
//       child: SignupPhoneView(),
//       backgroundColor: Colors.white,
//
//     );
//     SignupPhoneHandler();
//   }
// }
@override
Widget build(BuildContext context) {
  return Stack(
    children: [
      DefaultLayout(
        appBar: BackAppBar(title: ''),
        child: SignupPhoneView(),
        backgroundColor: Colors.white,
      ),
      SignupPhoneHandler(),
    ],
  );
}
}