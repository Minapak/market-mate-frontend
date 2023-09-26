import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/services_appbar.dart';
import 'package:sip_app/modules/service_center/widgets/mypage_services_view.dart';

class MypageServicesScreen extends StatelessWidget {
  const MypageServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: ServicesAppBar(title: '고객센터'),
      child: MypageServicesView(),
      backgroundColor: Colors.white,
    );
  }
}
