import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/colors.dart';

import '../providers/market_expert_handler.dart';

class MarketButton extends ConsumerWidget {
  final int marketId;


  const MarketButton(
      {required this.marketId, Key? key})
      : super();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onTapExpert() {
      if (marketId == null) {
        return;
      }
      ref.read(ShowMarketExpertProvider.notifier).onShow(marketId:marketId);
    }

    void onTapWholesale() {
      if (marketId == null) {
        return;
      }
     // ref.read(createExpertMatchingProvider.notifier).onMatch(expertId:expertId);
    }
    return BottomAppBar(
        elevation: 0,
        child: Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            width: double.infinity,
            height: 74,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                          print('도소매 보기');
                          onTapExpert();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: PRIMARY_DARK_BUTTON_COLOR,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: Text("도소매 보기",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        ))),
                SizedBox(width: 12),
                Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                          print('창업 정보 보기');
                          onTapExpert();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: NAVIGATION_TEXT_COLOR,
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          child: Text("창업 정보 보기",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                        )))
              ],
            )));
  }
}
