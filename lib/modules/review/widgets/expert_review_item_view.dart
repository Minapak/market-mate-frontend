import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/review/models/review_model.dart';

class ExpertReviewItemView extends StatelessWidget {
  final ReviewModel review;
  final String createdDateTime;
  ExpertReviewItemView({required this.review, required this.createdDateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: double.infinity,
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(children: [
            Expanded(
              flex: 0,
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                        image:
                            NetworkImage('https://via.placeholder.com/150'))),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(review.user.name,
                                  style: TextStyle(
                                      color: SECTION_FONT_COLOR,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                              Text(createdDateTime,
                                  style: TextStyle(
                                      color: BOTTOM_NAVI_TEXT_COLOR,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14))
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 1),
                            width: double.infinity,
                            height: 16,
                            child: StarItem(
                              rating: review.star,
                            ))
                      ]),
                )),
          ]),
        ),
        Container(
          child: Text(review.content,
              style: TextStyle(
                  color: COMMUNITY_CATEGORY_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
        )
      ]),
    );
  }
}

class StarItem extends StatelessWidget {
  final int rating;

  const StarItem({required this.rating, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(5, (index) {
        return SvgPicture.asset(
          index < rating
              ? 'assets/icons/icon_star_yellow.svg'
              : 'assets/icons/icon_star_gray.svg', // 별 모양 SVG 이미지 경로
          width: 16, //
          height: 16,
        );
      }),
    );
  }
}
