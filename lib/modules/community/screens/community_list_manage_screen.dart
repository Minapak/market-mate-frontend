import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/community/widgets/community_list_manage_view.dart';

class CommunitylistManageScreen extends StatelessWidget {
  const CommunitylistManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackAppBar(
          title: '내 글 ∙ 댓글 관리',
          actionWidget: GestureDetector(
              child: Container(
            margin: EdgeInsets.only(right: 20),
            alignment: Alignment.center,
          ))),
      child: CommunityListManageView(),
      backgroundColor: Colors.white,
    );
  }
}
