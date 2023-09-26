import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/common/widgets/main_appbar.dart';
import 'package:sip_app/modules/common/widgets/main_bottom_navigationbar.dart';

class CommunitiesScreen extends StatelessWidget {
  const CommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: MainAppBar(),
      child: Container(child: Text('커뮤니티')),
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      bottomNavigationBar: MainBottomNavigationBar(bottomTabIndex: 3),
      isNeedAppbar: true,
    );
  }
}
