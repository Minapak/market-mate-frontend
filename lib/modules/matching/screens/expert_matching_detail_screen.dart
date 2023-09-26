import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/common/widgets/fixed_bottom_multi_button.dart';
import 'package:sip_app/modules/matching/widgets/expert_matching_detail_view.dart';

class ExpertMatchingDetailScreen extends StatelessWidget {
  ExpertMatchingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackAppBar(title: '매칭 신청한 유저'),
      child: ExpertMatchingDetailView(),
      bottomNavigationBar: FixedBottomMultiButton(
        leftLabel: '매칭 거절',
        rightLabel: '매칭 수락',
      ),
    );
  }
}
