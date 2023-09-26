import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/market/models/market_model.dart';

class MarketIntroView extends StatelessWidget {
  final List<MarketModel> markets;

  MarketIntroView({required this.markets});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        scrollDirection: Axis.horizontal,
        child: Container(
          width: (MediaQuery.of(context).size.width - 30) * markets.length,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: markets.map((market) {
                return MarketItem(market: market);
              }).toList()),
        ));
  }
}

class MarketItem extends StatelessWidget {
  final MarketModel market;

  const MarketItem({required this.market, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: market.thumbnail ?? '',
      imageBuilder: (context, imageProvider) => Container(
          width: MediaQuery.of(context).size.width - 40,
          height: (MediaQuery.of(context).size.width - 40) * (7 / 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(market.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: -1))),
          )),
      placeholder: (context, url) => Container(
          width: MediaQuery.of(context).size.width - 40,
          height: (MediaQuery.of(context).size.width - 40) * (7 / 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: GRAY_COLOR_FONT,
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(market.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: -1))),
          )),
      errorWidget: (context, url, error) => Container(
          width: MediaQuery.of(context).size.width - 40,
          height: (MediaQuery.of(context).size.width - 40) * (7 / 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: GRAY_COLOR_FONT,
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(market.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        letterSpacing: -1))),
          )),
    );
  }
}
