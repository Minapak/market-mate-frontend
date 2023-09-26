import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/common/widgets/fixed_bottom_multi_button.dart';
import 'package:sip_app/modules/market/widgets/market_detail_view.dart';

class MarketDetailScreen extends StatelessWidget {
  final String marketId;
  final String marketName;
  const MarketDetailScreen({required this.marketId, required this.marketName, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackAppBar(title: marketName),
      child: MarketDetailView(marketId: int.parse(marketId)),
      backgroundColor: Colors.white,
      bottomNavigationBar: FixedBottomMultiButton(
        leftLabel: '도소매 보기',
        rightLabel: '창업 정보 보기',
      ),
    );
  }
}
