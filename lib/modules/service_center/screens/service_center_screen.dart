import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/common/widgets/services_appbar.dart';
import 'package:sip_app/modules/service_center/widgets/mypage_services_view.dart';
import 'package:sip_app/modules/service_center/widgets/service_center_view.dart';

class ServiceCenterScreen extends StatelessWidget {
  const ServiceCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackAppBar(title: '고객센터'),
      child: const ServiceCenterView(),
      backgroundColor: Colors.white,
    );
  }
}
