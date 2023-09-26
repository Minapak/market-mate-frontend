import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/common/widgets/fixed_bottom_button.dart';
import 'package:sip_app/modules/wholesaler/widgets/wholesaler_register_view.dart';

class WholesalerRegisterScreen extends StatelessWidget {
  const WholesalerRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackAppBar(title: '도/소매 상인 등록'),
      child: WholesalerRegisterView(),
      backgroundColor: Colors.white,
      bottomNavigationBar: FixedBottomButton(label: '등록완료'),
    );
  }
}
