import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/common/widgets/fixed_bottom_button.dart';
import 'package:sip_app/modules/expert/widgets/expert_register_view1.dart';

class MypageRegisterExpertScreen extends StatelessWidget {
  const MypageRegisterExpertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackAppBar(title: '전문가 등록'),
      child: MypageRegisterExpertView(),
      backgroundColor: Colors.white,
      bottomNavigationBar: FixedBottomButton(label: '등록완료'),
    );
  }
}
