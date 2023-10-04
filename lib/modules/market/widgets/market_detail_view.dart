import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/market/models/market_model.dart';
import 'package:sip_app/modules/market/providers/market_detail_provider.dart';
import 'package:sip_app/modules/market/widgets/market_detail_content_widget.dart';
import 'package:sip_app/modules/market/widgets/market_detail_image_widget.dart';
import 'package:sip_app/modules/market/widgets/market_detail_info_widget.dart';

class MarketDetailView extends ConsumerWidget {
  final int marketId;

  MarketDetailView({required this.marketId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(marketDetailNotifierProvider(marketId));

    if (data is ServerStatusLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is ServerStatusError) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final marketData = data as ServerStatusDataSuccess<MarketModel>;
    final market = marketData.data;

    return Container(
      child: SingleChildScrollView(
        child: Column(children: [
        Stack(children: [
          CarouselSlider(
              options: CarouselOptions(
                initialPage: 0,
                aspectRatio: 16 / 10.65,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                // enlargeCenterPage: true,
                // enlargeFactor: 0.2,
              ),
              items: List.generate(market.images!.length,
                      (i) => MarketImageItem(image: market.images![i]))),
        ]),
        SizedBox(height: 20),
        MarketInfo(
          name: market.name,
          mainCategories: market.mainCategories ?? [],
          middleCategories: market.middleCategories ?? [],
        ),
        SizedBox(height: 20),
        MarketContent(content: market.content ?? ''),
      ]),
    ));
  }
}

