import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/auth/providers/auth_provider.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/member/widgets/member_profile_handler.dart';
import 'package:sip_app/modules/member/widgets/mypage_profile_view.dart';

class MypageProfileScreen extends ConsumerWidget {
  const MypageProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        DefaultLayout(
          appBar: BackAppBar(
              title: '계정 설정',
              actionWidget: GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        ref.read(authProvider.notifier).onLogout();

                        // context.go(PATH_HOME);
                        // context.pushReplacement(PATH_HOME);
                        context.replace(PATH_HOME);
                        // Navigator.pushReplacementNamed(context, PATH_HOME);
                      },
                      child: Text('로그아웃',
                          style: TextStyle(
                              color: GRAY_COLOR_FONT,
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                    ),
                  ))),
          child: MypageProfileView(),
          backgroundColor: Colors.white,
        ),
        MemberProfileHandler(),
      ],
    );
  }
}
