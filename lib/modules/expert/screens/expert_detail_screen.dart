import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/expert/widgets/create_expert_matching_handler.dart';
import 'package:sip_app/modules/expert/widgets/expert_detail_view.dart';
import 'package:sip_app/modules/expert/widgets/expert_matching_button.dart';

class ExpertDetailScreen extends StatelessWidget {
  final String expertId;
  final String expertName;
  final String expertPhone;
  ExpertDetailScreen({required this.expertId, required this.expertName,required this.expertPhone});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultLayout(
          appBar: BackAppBar(title: '전문가 상세보기'),
         child: ExpertDetailView(expertId: '$expertId', expertPhone: expertPhone),


    bottomNavigationBar: ExpertMatchingButton(expertId: int.parse(expertId)),
        ),
     //   CreateExpertMatchingHandler(),
      ],
    );

  }
}
