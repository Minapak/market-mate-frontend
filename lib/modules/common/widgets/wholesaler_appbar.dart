import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/category/widgets/horizontal_category_list.dart';

class wholesalerAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(97.0);

  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Container(
                    height: 54,
                    padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                    child: OutlinedButton(
                        onPressed: () {
                          context.go(PATH_WHOLESALER_SEARCH);
                        },
                        style: OutlinedButton.styleFrom(
                            backgroundColor: INPUT_BACKGROUND_GRAY_COLOR,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                            side: const BorderSide(
                                width: 1.0,
                                color: INPUT_BACKGROUND_GRAY_COLOR),
                            padding:
                            const EdgeInsets.fromLTRB(20, 0, 20, 0))
                            .copyWith(overlayColor:
                        MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed)) {
                            return INPUT_BACKGROUND_GRAY_COLOR;
                          }
                          return null;
                        })),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 20,
                                height: 20,
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                    'assets/icons/icon_search.svg',
                                    fit: BoxFit.cover)),
                            SizedBox(width: 10),
                            Container(
                                height: 23,
                                margin: EdgeInsets.only(bottom: 4),
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  '도/소매 물품을 입력해주세요.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: GRAY_COLOR_FONT,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                          ],
                        )))),
            HorizontalCategoryList(type :CATEGORY_PAIR_EXPERT_TYPE),
          ],
        ));
  }
}

