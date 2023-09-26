
import 'package:flutter/material.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/modules/category/widgets/horizontal_category_list.dart';
import 'package:sip_app/modules/market/widgets/market_paginate_view.dart';

class MarketsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
     //   HorizontalCategoryList(type: CATEGORY_PAIR_MARKET_TYPE),
        Expanded(child: MarketPaginateView())
      ],
    ));
  }
}


