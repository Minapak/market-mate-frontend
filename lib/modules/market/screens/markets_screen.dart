
import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/common/widgets/market_appbar.dart';
import 'package:sip_app/modules/market/widgets/markets_view.dart';
import 'package:sip_app/modules/common/widgets/main_bottom_navigationbar.dart';

import '../../common/widgets/back_market_appbar.dart';

class MarketsScreen extends StatelessWidget {
  const MarketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackMarketAppBar(title:' 시장 보기'),
     // child: MarketsView(),
      // backgroundColor: PRIMARY_BACKGROUND_COLOR,
      child:  MarketsView(),
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      bottomNavigationBar: MainBottomNavigationBar(bottomTabIndex: 3),
      isNeedAppbar: true,
    );
  }
}