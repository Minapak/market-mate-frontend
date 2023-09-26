import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/common/widgets/active_dialog_widget.dart';
import 'package:sip_app/modules/review/models/review_model.dart';
import 'package:sip_app/modules/review/providers/delete_review_provider.dart';

class MypageReviewItemView extends ConsumerWidget {
  final ReviewModel review;
  final bool isLast;

  MypageReviewItemView({
    required this.review,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onClickDelete() {
      ref.read(deleteReviewNotifierProvider.notifier).deleteReview(reviewId: review.id);
    }

    return Container(
      margin: EdgeInsets.only(top: 30),
      width: double.infinity,
      child: Stack(
        children: [
          Column(children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(children: [
              Expanded(
                flex: 0,
                child: review.user.thumbnail != null ?
                Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          image:
                          NetworkImage('https://via.placeholder.com/150'))),
                ) : Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: IMAGE_UPLOAD_BUTTON_COLOR,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 22,
                      height: 22,
                      child: SvgPicture.asset('assets/icons/icon_user_default.svg', fit: BoxFit.cover,),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(review.user.nickname,
                                        style: TextStyle(
                                            color: SECTION_FONT_COLOR,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Container(
                                        width: 5,
                                        height: 10,
                                        margin: EdgeInsets.only(left: 6),
                                        child: SvgPicture.asset(
                                            'assets/icons/icon_right_black.svg',
                                            fit: BoxFit.cover)),
                                  ],
                                )
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
            child: Text(
                review.content,
                style: TextStyle(
                    color: COMMUNITY_CATEGORY_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
          ),
          SizedBox(height: 8),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(review.createdDateTime ?? '',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: BOTTOM_NAVI_TEXT_COLOR,
                    fontWeight: FontWeight.w400,
                    fontSize: 14)),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 1,
            color: isLast ? Colors.white : BUTTON_GRAY_BORDER_COLOR,
          ),
        ]),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap:() {
              Future.microtask(() =>
                  ActiveDialog.showActive(
                      context,
                      title: '리뷰 삭제',
                      message: '해당 리뷰를 삭제하시겠습니까?',
                      onClickYes:onClickDelete
                  ));
            },
            child: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset('assets/icons/icon_x_gray.svg', fit: BoxFit.cover),
            ),
          ))
        ],
      )
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
