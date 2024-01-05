import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';
import 'package:sip_app/modules/matching/models/matching_model.dart';
import 'package:sip_app/utils/data_to_string.dart';
import 'package:sip_app/modules/category/widgets/middle_category_hashtag_view.dart';
import 'package:go_router/go_router.dart';

class ExpertCardItemView extends StatelessWidget {
  final ExpertModel expert;
  final bool isNeedIntroduce;
  final bool isNeedMatchingStatus;
  final bool isNeedHeart;
  final MatchingStatus? matchingStatus;

  const ExpertCardItemView(
      {required this.expert,
      this.isNeedIntroduce = false,
      this.isNeedMatchingStatus = false,
      this.isNeedHeart = false,
      this.matchingStatus,
      Key? key})
      : super(key: key);

  Widget renderIntroduceWidget() {
    if (isNeedIntroduce) {
      return Text(expert.content ?? '',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: GRAY_COLOR_FONT,
              fontSize: 12,
              fontWeight: FontWeight.w500));
    } else {
      return SizedBox.shrink();
    }
  }

  Widget renderFixedItem() {
    if (isNeedMatchingStatus && matchingStatus != null) {
      final String matchingStatusToString =
          getMatchingStatusToString(matchingStatus!);
      final Color matchingStatusBgColor =
          getMatchingStatusBgColor(matchingStatus!);
      final Color matchingStatusFontColor =
          getMatchingStatusFontColor(matchingStatus!);

      return Positioned(
          right: 10, // 0 units from the right side of the screen
          top: 10, // 0 units from the top of the screen
          child: Container(
              height: 26,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              decoration: BoxDecoration(
                color: matchingStatusBgColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              child: Text(
                textAlign: TextAlign.center,
                matchingStatusToString,
                style: TextStyle(
                    color: matchingStatusFontColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              )));
    } else if (isNeedHeart) {
      return Positioned(
          right: 13, // 0 units from the right side of the screen
          top: 13, // 0 units from the top of the screen
          child: SizedBox(
            height: 24,
            width: 24,
            child: SvgPicture.asset('assets/icons/icon_heart_on.svg'),
          ));
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push('/users/experts');
        },
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: IntrinsicHeight(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: NetworkImage(expert.thumbnail ?? ''),
                                  fit: BoxFit.cover)),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${expert.name} 전문가',
                                      style: TextStyle(
                                          color: FIXED_WIDGET_BACKGROUNG_COLOR,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text('${expert.marketName}',
                                      style: TextStyle(
                                          color: COMMUNITY_CATEGORY_COLOR,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  renderIntroduceWidget(),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Wrap(
                                    children: expert.middleCategories
                                            ?.map((item) => HashtagItemView(
                                                name: item.name))
                                            .toList() ??
                                        [],
                                  )
                                ],
                              ),
                            ))
                      ]),
                )),
            renderFixedItem()
          ],
        ));
  }
}
