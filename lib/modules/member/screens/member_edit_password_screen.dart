import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/member/widgets/member_edit_password_handler.dart';
import 'package:sip_app/modules/member/widgets/member_edit_password_view.dart';

class MemberEditPasswordScreen extends StatelessWidget {
  MemberEditPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultLayout(
          appBar: BackAppBar(
            title: '비밀번호 수정',
          ),
          child: MemberEditPasswordView(),
          backgroundColor: Colors.white,
        ),
        MemberEditPasswordHandler(),
      ],
    );
  }
}
