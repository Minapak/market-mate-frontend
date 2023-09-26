import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/member/models/member_model.dart';

class MemberView extends StatelessWidget {
  final List<MemberModel> members;

  const MemberView({required this.members, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white),
      child: Column(children: [
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('마이페이지',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            TextButton(
                onPressed: () {},
                child: TextButton(
                  onPressed: () {
                    context.go(PATH_MYPAGE);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('전체보기',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: NAVIGATION_TEXT_COLOR)),
                      SizedBox(width: 6),
                      Container(
                        width: 5,
                        height: 10,
                        margin: EdgeInsets.only(top: 1),
                        child: SvgPicture.asset(
                            'assets/icons/icon_arrow_right_blue.svg',
                            fit: BoxFit.cover),
                      )
                    ],
                  ),
                ))
          ],
        )),
        SizedBox(height: 20),
        ...List.generate(
            members.length,
            (i) => MemberItem(
                members: members[i], isLast: members.length == i + 1))
      ]),
    );
  }
}

class MemberItem extends StatelessWidget {
  final MemberModel members;
  final bool isLast;

  const MemberItem({required this.members, required this.isLast, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(members.name,
            style: TextStyle(
                color: COMMUNITY_CATEGORY_COLOR,
                fontWeight: FontWeight.w500,
                fontSize: 14)),
        SizedBox(height: 8),
        Text(members.phone,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: BLACK_COLOR_FONT,
                fontSize: 16,
                fontWeight: FontWeight.w500)),

        SizedBox(height: 18),

        SizedBox(height: 18),
        isLast
            ? SizedBox()
            : Column(
                children: [
                  Container(height: 1, color: INPUT_BACKGROUND_GRAY_COLOR),
                  SizedBox(height: 20),
                ],
              ),
      ],
    );
  }
}
