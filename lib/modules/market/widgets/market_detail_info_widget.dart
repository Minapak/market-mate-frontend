import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';
import 'package:sip_app/modules/category/models/middle_category_model.dart';
import 'package:sip_app/modules/category/widgets/main_category_hashtag_view.dart';
import 'package:sip_app/modules/category/widgets/middle_category_hashtag_view.dart';

class MarketInfo extends StatelessWidget {
  final String name;
  final List<MainCategoryModel> mainCategories;
  final List<MiddleCategoryModel> middleCategories;

  MarketInfo({
    required this.name,
    required this.mainCategories,
    required this.middleCategories
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        color: FIXED_WIDGET_BACKGROUNG_COLOR,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 16,
                ),
                Wrap(
                  children: mainCategories
                      .map((category) => CategoryHashtagView(name: category.name))
                      .toList(),
                ),
                Wrap(
                    children: middleCategories
                        .map((sub) => HashtagItemView(name: sub.name))
                        .toList())
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: GestureDetector(
              child: Container(
                width: 40,
                height: 40,
                padding: EdgeInsets.fromLTRB(13, 11, 13, 11),
                decoration: BoxDecoration(
                    border:
                    Border.all(color: BUTTON_GRAY_BORDER_COLOR, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                    width: 13.75,
                    height: 17.5,
                    child: SvgPicture.asset(
                      'assets/icons/icon_map.svg',
                      fit: BoxFit.cover,
                    )),
              ),
            ))
        ],
      ),
    );
  }
}
