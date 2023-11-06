import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';
import 'package:sip_app/modules/category/models/middle_category_model.dart';
import 'package:sip_app/modules/expert/widgets/expert_info_view.dart';
import 'package:sip_app/modules/expert/providers/expert_detail_provider.dart';
import 'package:sip_app/modules/expert/widgets/expert_wish_heart_widget.dart';
import 'package:sip_app/modules/review/widgets/expert_reviews_view.dart';
import 'package:sip_app/utils/data_to_string.dart';
import 'package:sip_app/modules/category/widgets/main_category_hashtag_view.dart';
import 'package:sip_app/modules/category/widgets/middle_category_hashtag_view.dart';

final String infoType = 'info';
final String reviewType = 'review';

class ExpertDetailView extends ConsumerWidget {
  final String expertId;

  ExpertDetailView({required this.expertId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(expertCacheProvider(int.parse(expertId)));
    final bool isLoading = config.isLoading;
    final bool isError = config.isError;
    final ExpertModel? state = config.expert;
    final ScrollController scrollController = ScrollController();

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (isError || state == null) {
      return Center(
        child: Text('에러입니다.'),
      );
    }

    String displayCareer(ExpertCareer? career) {
      if (career == null) {
        return '';
      } else {
        return getCareerToString(career);
      }
    }

    return ListView(
      children: <Widget>[
        ExpertDetailImageView(
          thumbnail: state.thumbnail ?? '',
        ),
        ExpertBasicInfoView(
          expertId: state.id,
          expertName: state.name,
          marketName: state.marketName ?? '',
          mainCategories: state.mainCategories,
          middleCategories: state.middleCategories,
        ),
        // ExpertIntroView(content: state.content),
        ExpertTabView(
          expertId: state.id,
          scrollController: scrollController,
          content: state.content ?? '',
          career: displayCareer(state.career),
        ),
      ],
    );
  }
}

class ExpertDetailImageView extends StatelessWidget {
  final String thumbnail;

  ExpertDetailImageView({required this.thumbnail});

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

class ExpertBasicInfoView extends StatelessWidget {
  final int expertId;
  final String expertName;
  final String marketName;
  final List<MainCategoryModel>? mainCategories;
  final List<MiddleCategoryModel>? middleCategories;

  ExpertBasicInfoView({
      required this.expertId,
      required this.expertName,
      required this.marketName,
      this.mainCategories,
      this.middleCategories});

  Future<void> saveExpertIdToSharedPreferences(int expertId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('expertId', expertId);
  }
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
              Text('${expertName} 전문가',
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
                  children: middleCategories!
                      .map((sub) => HashtagItemView(name: sub.name))
                      .toList())
                  : SizedBox.shrink(),
            ],
          ),
          ExpertWishHeart(expertId: expertId),
        ],
      )
    );
  }
}

class ExpertIntroView extends StatelessWidget {
  final String content;

  const ExpertIntroView({required this.content, Key? key}) : super(key: key);

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

class ExpertTabView extends StatefulWidget {
  final String content;
  final String career;
  final ScrollController scrollController;
  final int expertId;

  ExpertTabView(
      {required this.content,
      required this.career,
      required this.scrollController,
      required this.expertId});

  @override
  ExpertTabViewState createState() => ExpertTabViewState();
}

class ExpertTabViewState extends State<ExpertTabView> {
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
                              '전문가 정보',
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
                ? ExpertInfoView(
                    career: widget.career,
                    content: widget.content,
                  )
                : ExpertReviewsView(
                    expertId: widget.expertId,
                    scrollController: widget.scrollController,
                  )
          ],
        ));
  }
}
