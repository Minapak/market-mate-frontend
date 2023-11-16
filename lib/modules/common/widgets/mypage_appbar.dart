import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Get 패키지 추가
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/config/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/path.dart';
import '../../../utils/assete_icon_paths.dart';


class MyPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(54.0);


  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      automaticallyImplyLeading: false,
      flexibleSpace: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // 로고 클릭 시 처리
//새로고침
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 40,
                    height: 40,
                    // child: SvgPicture.asset(
                    //   'assets/logos/logo_small.svg',
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // 가운데 공백란
                  },
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.6,
                    height: 40,
                    padding: EdgeInsets.only(left: 10),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {

                    Future<SharedPreferences> userEmail = SharedPreferences.getInstance();
                    String email = userEmail.toString(); // 이메일 값을 가져옵니다.
                    print('email : ${email}');
                    print('유저 아이디 : ${userEmail.toString()}');
                    // 사람 클릭 시 로그인 페이지 또는 마이페이지로 이동
                    if (email != null) {
                      // 이미 로그인되어 있으면 마이페이지로 이동
                      context.go(PATH_MYPAGE);
                    } else {
                      // 로그인되어 있지 않으면 로그인 페이지로 이동
                      context.go(PATH_SIGNIN);
                    }

                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    width: 20,
                    height: 20,
                    // child: SvgPicture.asset(
                    //   'assets/icons/icon_user.svg',
                    //   fit: BoxFit.cover,
                    //   color: ColorFile.greyColor,
                    // ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}

