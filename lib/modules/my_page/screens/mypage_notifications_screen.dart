import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/my_page/widgets/mypage_notifications_view.dart';

class MypageNotificationsScreen extends StatelessWidget {
  const MypageNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackAppBar(title: '알림 설정'),
      child: MypageNotificationsView(),
      backgroundColor: Colors.white,
    );
  }
}
