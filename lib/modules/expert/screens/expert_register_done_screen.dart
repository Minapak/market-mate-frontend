import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/expert/widgets/create_expert_matching_handler.dart';
import 'package:sip_app/modules/expert/widgets/expert_detail_view.dart';
import 'package:sip_app/modules/expert/widgets/expert_matching_button.dart';

class ExpertRegisterDoneScreen extends StatelessWidget {
  final String expertId;
  final String expertName;

  ExpertRegisterDoneScreen({required this.expertId, required this.expertName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultLayout(
          appBar: BackAppBar(title: '$expertName 전문가'),
          child: ExpertDetailView(expertId: expertId),
          bottomNavigationBar: ExpertMatchingButton(expertId: int.parse(expertId)),
        ),
        CreateExpertMatchingHandler(),
      ],
    );
  }
}
