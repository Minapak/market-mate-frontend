import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/wholesaler/models/wholesaler_model.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';
import 'package:sip_app/modules/category/models/middle_category_model.dart';
import 'package:sip_app/modules/wholesaler/widgets/wholesaler_info_view.dart';
import 'package:sip_app/modules/wholesaler/providers/wholesaler_detail_provider.dart';
import 'package:sip_app/modules/wholesaler/widgets/wholesaler_wish_heart_widget.dart';
import 'package:sip_app/modules/review/widgets/wholesaler_reviews_view.dart';
import 'package:sip_app/utils/data_to_string.dart';
import 'package:sip_app/modules/category/widgets/main_category_hashtag_view.dart';
import 'package:sip_app/modules/category/widgets/middle_category_hashtag_view.dart';

import '../models/wholesaler_model.dart';

final String infoType = 'info';
final String reviewType = 'review';

class wholesalerDetailView extends ConsumerWidget {
  final String wholesalerId;

  wholesalerDetailView({required this.wholesalerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(wholesalerCacheProvider(int.parse(wholesalerId)));
    final bool isLoading = config.isLoading;
    final bool isError = config.isError;
    final wholesalerModel? wholesalerstate = config.wholesaler;
    final ScrollController scrollController = ScrollController();

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (isError || wholesalerstate == null) {
      return Center(
        child: Text('에러입니다.'),
      );
    }

    // String displayCareer(wholesalerCareer career) {
    //   if (career == null) {
    //     return '';
    //   } else {
    //     return getCareerToString(career);
    //   }
    // }

    return ListView(
      children: <Widget>[
        wholesalerDetailImageView(
          thumbnail: wholesalerstate.thumbnail ?? '',
        ),
        wholesalerBasicInfoView(
          wholesalerId: wholesalerstate.id,
          wholesalerName: wholesalerstate.name,
          marketName: wholesalerstate.marketName ?? '',
          mainCategories: wholesalerstate.mainCategories,
          middleCategories: wholesalerstate.middleCategories,
        ),
        // ExpertIntroView(content: state.content),
        wholesalerTabView(
          wholesalerId: wholesalerstate.id,
          scrollController: scrollController,
          content: wholesalerstate.content ?? ''
        //  career: displayCareer(wholesalerstate.career),
        ),
      ],
    );
  }
}

class wholesalerDetailImageView extends StatelessWidget {
  final String thumbnail;

  wholesalerDetailImageView({required this.thumbnail});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AspectRatio(
          aspectRatio: 16 / 11,
          child: Image(
            image: NetworkImage(thumbnail),
            fit: BoxFit.cover,
          )),
    );
  }
}

class wholesalerBasicInfoView extends StatelessWidget {
  final int wholesalerId;
  final String wholesalerName;
  final String marketName;
  final List<MainCategoryModel>? mainCategories;
  final List<MiddleCategoryModel>? middleCategories;

  wholesalerBasicInfoView({
      required this.wholesalerId,
      required this.wholesalerName,
      required this.marketName,
      this.mainCategories,
      this.middleCategories});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${wholesalerName} 도/소매 상인',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: FIXED_WIDGET_BACKGROUNG_COLOR,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
              Text(marketName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: COMMUNITY_CATEGORY_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: 14),
              mainCategories != null
                  ? Wrap(
                  children: mainCategories!
                      .map((category) =>
                      CategoryHashtagView(name: category.name))
                      .toList())
                  : SizedBox.shrink(),
              middleCategories != null
                  ? Wrap(
                  children: mainCategories!
                      .map((sub) => HashtagItemView(name: sub.name))
                      .toList())
                  : SizedBox.shrink(),
            ],
          ),
          wholesalerWishHeart(wholesalerId: wholesalerId),
        ],
      )
    );
  }
}

class wholesalerIntroView extends StatelessWidget {
  final String content;

  const wholesalerIntroView({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Container(
      width: double.infinity,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Text(content,
          style: TextStyle(
              color: SECTION_FONT_COLOR,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
    ));
  }
}

class wholesalerTabView extends StatefulWidget {
  final String content;
  //final String career;
  final ScrollController scrollController;
  final int wholesalerId;

  wholesalerTabView(
      {required this.content,
    //  required this.career,
      required this.scrollController,
      required this.wholesalerId});

  @override
  wholesalerTabViewState createState() => wholesalerTabViewState();
}

class wholesalerTabViewState extends State<wholesalerTabView> {
  String currentType = infoType;

  void onTab(String type) {
    if (type == currentType) return;

    setState(() {
      currentType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 6, 20, 112),
        child: Column(
          children: [
            Container(
                height: 44,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            onTab(infoType);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 11, 0, 12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: currentType == infoType
                                        ? NAVIGATION_TEXT_COLOR
                                        : INPUT_BACKGROUND_GRAY_COLOR,
                                    width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Text(
                              '도/소매 상인 정보',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: currentType == infoType
                                      ? NAVIGATION_TEXT_COLOR
                                      : BOTTOM_NAVI_TEXT_COLOR,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        )),
                    SizedBox(width: 16),
                    Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            onTab(reviewType);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 11, 0, 12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: currentType == reviewType
                                        ? NAVIGATION_TEXT_COLOR
                                        : INPUT_BACKGROUND_GRAY_COLOR,
                                    width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Text(
                              '리뷰',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: currentType == reviewType
                                      ? NAVIGATION_TEXT_COLOR
                                      : BOTTOM_NAVI_TEXT_COLOR,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        )),
                  ],
                )),
            SizedBox(height: 30),
            currentType == infoType
                ? wholesalerInfoView(
                  //  career: widget.career,
                    content: widget.content,
                  )
                : wholesalerReviewsView(
                     wholesalerId: widget.wholesalerId,
                    scrollController: widget.scrollController,
                  )
          ],
        ));
  }
}
