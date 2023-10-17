import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/member/models/member_edit_type_model.dart';
import 'package:sip_app/modules/member/models/member_model.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';
import 'package:sip_app/modules/member/widgets/member_image_view.dart';

class MypageProfileView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(memberNotifierProvider);

    return data.when(data: (data) {
      return Container(
          padding: EdgeInsets.fromLTRB(20, 40, 20, 40),
          height: MediaQuery.of(context).size.height - 50,
          child: Column(
            children: [
              ProfileWrapper(user: data),
              Spacer(),
              MypageWithdrawal(),
            ],
          ));
    }, error: (error, stack) {
      return Center(
        child: Text('에러'),
      );
    }, loading: () {
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

class ProfileWrapper extends StatelessWidget {
  final MemberModel user;

  ProfileWrapper({required this.user});

  @override
  Widget build(BuildContext context) {

    print('user.thumbnail!!!!!!! : ${user.thumbnail}');
    return Container(

      child: Column(
        children: [
          MemberImageView(currentImage: user.thumbnail),

          SizedBox(
            height: 40,
          ),
          ProfileItem(
            member: user,
            editType: MemberEditType.NICKNAME,
            label: '이름',
            children: Text(user.nickname,
                style: TextStyle(
                    color: SECTION_FONT_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ),
          ProfileItem(
              member: user,
              editType: MemberEditType.NONE,
              label: '이메일',
              children: Text(user.identyKey,
                  style: TextStyle(
                      color: BLACK_COLOR_FONT,
                      fontSize: 14,
                      fontWeight: FontWeight.w400))),
          ProfileItem(
            member: user,
            editType: MemberEditType.PASSWORD,
            label: '비밀번호',
            children: Text('******',
                style: TextStyle(
                    color: SECTION_FONT_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ),
          ProfileItem(
            member: user,
            editType: MemberEditType.PHONE,
            label: '휴대전화번호',
            children: Text(user.phone,
                style: TextStyle(
                    color: SECTION_FONT_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

}



class ProfileItem extends StatelessWidget {
  final MemberModel member;
  final String label;
  final MemberEditType editType;
  final Widget? children;

  const ProfileItem(
      {required this.member,
      required this.label,
      required this.editType,
      this.children,
      Key? key})
      : super();

  @override
  Widget build(BuildContext context) {
    final bool isCanEdit = editType != MemberEditType.NONE;

    return GestureDetector(
        onTap: () {
          if (!isCanEdit) return;

          switch(editType) {
            case MemberEditType.NICKNAME:
              context.pushNamed('editNickname', queryParameters: {"nickname": member.nickname});
              return;
            case MemberEditType.PASSWORD:
              context.pushNamed('editPassword');
              return;
            default:
              break;
          }
        },
        child: AbsorbPointer(
          child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(label,
                              style: TextStyle(
                                  color: GRAY_COLOR_FONT,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: 10),
                          children ?? SizedBox.shrink()
                        ],
                      ),
                      isCanEdit
                          ? Container(
                              width: 6,
                              height: 12,
                              child: SvgPicture.asset(
                                  'assets/icons/icon_right_black.svg',
                                  fit: BoxFit.cover))
                          : SizedBox.shrink()
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                      width: double.infinity,
                      height: 1,
                      color: INPUT_BACKGROUND_GRAY_COLOR)
                ],
              )),
        ));
  }
}

class MypageWithdrawal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('계정 탈퇴',
              style: TextStyle(
                  color: COMMUNITY_CATEGORY_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          Container(
              width: 6,
              height: 12,
              child: SvgPicture.asset('assets/icons/icon_right_black.svg',
                  fit: BoxFit.cover)),
        ],
      ),
    );
  }
}
