import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/matching/widgets/matchings_view.dart';

class MypageMatchingsScreen extends StatelessWidget {
  MypageMatchingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackAppBar(title: '전문가 매칭목록'),
      child: MypageMatchingsView(),
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
    );
  }
}
