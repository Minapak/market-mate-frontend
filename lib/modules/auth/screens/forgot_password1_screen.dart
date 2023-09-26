import 'package:sip_app/helpers/theme/app_theme.dart';
import 'package:sip_app/helpers/widgets/my_button.dart';
import 'package:sip_app/helpers/widgets/my_container.dart';
import 'package:sip_app/helpers/widgets/my_spacing.dart';
import 'package:sip_app/helpers/widgets/my_text.dart';
import 'package:sip_app/helpers/widgets/my_text_style.dart';
import 'package:sip_app/modules/auth/screens/signin_screen.dart';
import 'package:sip_app/modules/auth/widgets/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/common/widgets/home_appbar.dart';
class ForgotPassword1Screen extends StatefulWidget {
  @override
  _ForgotPassword1ScreenState createState() => _ForgotPassword1ScreenState();
}

class _ForgotPassword1ScreenState extends State<ForgotPassword1Screen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: '', // AppBar의 타이틀 설정
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: _MyCustomClipper(context),
            child: Container(
              alignment: Alignment.center,
              color: theme.colorScheme.background,
            ),
          ),
          Positioned(
            left: 30,
            right: 30,
            top: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: <Widget>[
                MyContainer.bordered(
                  color: theme.scaffoldBackgroundColor,
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 24, top: 8),
                        child: MyText.titleLarge("비밀번호 찾기", fontWeight: 600),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              style: MyTextStyle.bodyLarge(
                                letterSpacing: 0.1,
                                color: theme.colorScheme.onBackground,
                                fontWeight: 500,
                              ),
                              decoration: InputDecoration(
                                hintText: "가입하신 이메일을 적어주세요",
                                hintStyle: MyTextStyle.titleSmall(
                                  letterSpacing: 0.1,
                                  color: theme.colorScheme.onBackground,
                                  fontWeight: 500,
                                ),
                                prefixIcon: Icon(LucideIcons.mail),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              child: MyButton(
                                elevation: 0,
                                borderRadiusAll: 4,
                                padding: MySpacing.xy(16, 20),
                                onPressed: () {
                                  _showResetPasswordDialog(context);
                                },
                                child: MyText.labelMedium(
                                  "비밀번호 초기화",
                                  fontWeight: 600,
                                  color: theme.colorScheme.onPrimary,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MyCustomClipper extends CustomClipper<Path> {
  final BuildContext _context;

  _MyCustomClipper(this._context);

  @override
  Path getClip(Size size) {
    final path = Path();
    Size size = MediaQuery.of(_context).size;
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.3);
    path.lineTo(0, size.height * 0.6);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

void _showResetPasswordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('비밀번호 초기화 요청'),
        content: Text('비밀번호 초기화 링크를 이메일로 보내드릴 것입니다. 계속하시겠습니까?'),
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
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SigninView(), // 로그인 화면으로 이동
                ),
              );
            },
          ),
        ],
      );
    },
  );
}