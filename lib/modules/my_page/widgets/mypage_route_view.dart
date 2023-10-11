import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/route_model.dart';
import 'package:go_router/go_router.dart';

List<RouteModel> routes = [
 // RouteModel(id: 1, name: '전문가 매칭목록', link: PATH_USER_MATCHINGS),
  RouteModel(id: 1, name: '찜한 전문가 리스트', link: PATH_USER_WISHLIST),
  RouteModel(id: 1, name: '나의 리뷰', link: PATH_USER_REVIEWS),
  //RouteModel(id: 1, name: '내 글 ∙ 댓글 관리', link: PATH_USER_COMMUNITIES),
 // RouteModel(id: 1, name: '알림 설정', link: PATH_USER_NOTIFICATIONS),
  RouteModel(id: 1, name: '고객센터', link: PATH_SERVICES),
  RouteModel(id: 1, name: '전문가 등록', link: PATH_USER_EXPERT),
];

class MypageRouteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      child: Column(
          children: List.generate(
              routes.length,
              (i) => MyPageRouteItem(
                    route: routes[i],
                    isLastIndex: i + 1 == routes.length,
                  ))),
    );
  }
}

class MyPageRouteItem extends StatelessWidget {
  final RouteModel route;
  final bool isLastIndex;

  const MyPageRouteItem(
      {required this.route, required this.isLastIndex, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onTap() {
      context.push(route.link);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: isLastIndex ? Colors.white : INPUT_BACKGROUND_GRAY_COLOR,
            width: 1,
          ))),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                route.name,
                style: TextStyle(
                    color: SECTION_FONT_COLOR,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                width: 4,
                height: 8,
                child: SvgPicture.asset('assets/icons/icon_right_small.svg',
                    fit: BoxFit.cover),
              ),
            ],
          )),
    );
  }
}
