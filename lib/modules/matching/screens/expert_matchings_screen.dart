import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/matching/widgets/expert_matchings_view.dart';

class ExpertMatchingsScreen extends StatelessWidget {
  ExpertMatchingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackAppBar(title: '매칭 신청리스트'),
      child: ExpertMatchingsView(),
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
    );
  }
}
