import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/auth/providers/auth_provider.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/main_bottom_navigationbar.dart';
import 'package:sip_app/modules/my_page/widgets/mypage_view.dart';

import '../../../constants/colors.dart';
import '../../common/widgets/main_appbar.dart';
import '../../common/widgets/mypage_appbar.dart';

class MypageScreen extends ConsumerWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLoggedIn = ref.watch(checkLoggedInProvider);

    return DefaultLayout(

      appBar: MyPageAppBar(), // MainAppBar 추가
      child: isLoggedIn ? MyPageView() : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              width: 100, // 로고 이미지의 가로 크기
              height: 100, // 로고 이미지의 세로 크기
              decoration: BoxDecoration(
                color: Colors.white, // 로고 이미지 배경색
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // 그림자 색상
                    spreadRadius: 2, // 그림자 확산 반경
                    blurRadius: 5, // 그림자 블러 효과 반경
                    offset: Offset(0, 3), // 그림자 위치 (가로, 세로)
                  ),
                ],
              ),
              child: SvgPicture.asset(
                'assets/logos/logo_small.svg', // 로고 이미지 파일 경로
                fit: BoxFit.contain, // 이미지 크기 조절 옵션 (필요에 따라 설정)
              ),
            ),
            SizedBox(height: 30), // 이미지와 버튼 사이의 간격 조절
            ElevatedButton(
              onPressed: () {
                context.push(PATH_SIGNIN);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('시프 로그인 하러가기'),
                  //  Icon(Icons.login), // 로그인 아이콘 또는 원하는 로고 아이콘을 여기에 추가
                ],
              ),
            ),
            SizedBox(height: 16), // 텍스트와 버튼 사이의 간격 조절
            // 로고 이미지를 추가하는 방법 (아래 예제는 이미지 파일 경로를 사용)
          ],
        ),
      ),
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
      bottomNavigationBar: MainBottomNavigationBar(bottomTabIndex: 4),
    );
  }
}






