import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';

class ExpertMatchingDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              items: List.generate(2,
                      (i) => ExpertMatchingDetailImageWidget())),
        ]),
        ExpertMatchingDetailInfo(),
        // MarketInfo(
        //   name: market.name,
        //   mainCategories: market.mainCategories ?? [],
        //   middleCategories: market.middleCategories ?? [],
        // ),
        SizedBox(height: 20),

        // MarketContent(content: market.content ?? ''),
      ]),
    );
  }
}

class ExpertMatchingDetailInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              ExpertMatchingDetailInfoLabel(),
              ExpertMatchingDetailInfoLabel(),
              ExpertMatchingDetailInfoLabel(),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: INPUT_BORDER_GRAY_COLOR,
                width: 1,
              ),
            ),
            child: Text(
              '매니저 문의',
              style: TextStyle(
                fontSize: 12,
                color: COMMUNITY_CATEGORY_COLOR,
                fontWeight: FontWeight.w500,
              ),
            ),
          )

        ],
      ),
    );
  }
}



class ExpertMatchingDetailInfoLabel extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text('신청번호',
        style:  TextStyle(color: BLACK_COLOR_FONT, fontSize: 16, fontWeight: FontWeight.w500),),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          width: 1,
          height: 10,
          decoration: BoxDecoration(color: INPUT_BORDER_GRAY_COLOR),
        ),
        Text('000000', style:  TextStyle(color: COMMUNITY_CATEGORY_COLOR, fontSize: 16, fontWeight: FontWeight.w500))
      ],
    );
  }
}

class ExpertMatchingDetailImageWidget extends StatelessWidget {

  ExpertMatchingDetailImageWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('https://via.placeholder.com/150'),
              fit: BoxFit.cover)),
    );
  }
}
