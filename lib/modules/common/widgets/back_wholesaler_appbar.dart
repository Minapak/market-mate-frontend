import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/main.dart';
import 'package:sip_app/modules/main/screens/home_screen.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/path.dart';
import '../../auth/widgets/signin_view.dart';
import '../../category/widgets/horizontal_category_list.dart';

class BackWholesalerAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? actionWidget;

  const BackWholesalerAppBar({required this.title, this.actionWidget, Key? key})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(100.0);

  Widget build(BuildContext context) {
    return AppBar(
      primary: true,
      backgroundColor: Colors.white,
      title: Text(title,
          style: TextStyle(
            color: SECTION_FONT_COLOR,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
      elevation: 0,
        centerTitle: true,
        flexibleSpace: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    height: 54,
                    padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
                    child:  IconButton(
                        icon: SvgPicture.asset('assets/icons/icon_back.svg'),
                        onPressed: () {
                         // Navigator.pop(context); // 현재 화면 닫기
                          context.go(PATH_HOME);
                        },
                       ))),
            HorizontalCategoryList(type :CATEGORY_PAIR_EXPERT_TYPE),
          ],
        )

    );
  }
}


void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('돌아가기'),
        content: Text('로그인페이지로 돌아갑니다'),
        actions: <Widget>[
          TextButton(
            child: Text('취소'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('확인'),
            onPressed: () {
              // 여기에서 실제 초기화 요청을 보내거나 작업을 수행할 수 있습니다.
              // 작업이 완료되면 알림 창을 닫아야 합니다.
              Navigator.of(context).pop(); // 다이얼로그 닫기
              context.go(PATH_HOME);
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => SigninView(), // 로그인 화면으로 이동
              //   ),
              //   );
            },
          ),
        ],
      );
    },
  );
}