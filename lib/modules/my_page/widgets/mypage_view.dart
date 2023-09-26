import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/member/models/member_model.dart';
import 'package:sip_app/modules/member/widgets/member_image_view.dart';
import 'package:sip_app/modules/my_page/widgets/mypage_route_view.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';

class MyPageView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberData = ref.watch(memberNotifierProvider);
    return memberData.when(data: (data) {
      return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              MyPageUserInfoView(
                user: data,
              ),
              SizedBox(height: 20),
              MypageRouteView()
            ],
          ));
    }, error: (error, stack) {
      return Center(child: Text('알 수 없는 에러'));
    }, loading: () {
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

class MyPageUserInfoView extends StatelessWidget {
  final MemberModel user;

  MyPageUserInfoView({required this.user});

  @override
  Widget build(BuildContext context) {
    void onTap() {
      context.push(PATH_USER_PROFILE);
    }

    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 20),
          decoration: BoxDecoration(
            color: INPUT_BACKGROUND_GRAY_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(50)),
                              image: DecorationImage(
                                  image: NetworkImage(user.thumbnail ??
                                      'https://via.placeholder.com/150'), fit: BoxFit.cover)),
                        ),
                        Container(
                          height: 60,
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${user.nickname} 고객님',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: BLACK_COLOR_FONT,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                Container(
                                  child: Text(
                                    user.identyKey,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: GRAY_COLOR_FONT,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ]),
                        )
                      ],
                    )),
                Expanded(
                    flex: 0,
                    child: GestureDetector(
                        child: Container(
                      padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                      decoration: BoxDecoration(
                          color: INPUT_BORDER_GRAY_COLOR,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text('설정',
                          style: TextStyle(
                            color: COMMUNITY_CATEGORY_COLOR,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          )),
                    )))
              ]),
        ));
  }
}
