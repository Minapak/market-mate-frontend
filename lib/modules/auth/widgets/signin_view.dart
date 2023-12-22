import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/commons/auth/auth_service.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/auth/providers/auth_provider.dart';
import 'package:sip_app/modules/auth/providers/signin_email_provider.dart';
import 'package:sip_app/modules/auth/providers/signin_provider.dart';
import 'package:sip_app/modules/auth/widgets/signin_email_input_widget.dart';
import 'package:sip_app/modules/auth/widgets/signin_password_input_widget.dart';

import 'package:sip_app/utils/jwt.dart';
import 'package:http/http.dart' as http;
//소셜 로그인
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
class SigninView extends StatelessWidget {
  const SigninView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [const SigninLogo(), SigninForm()],
          ),
        ));
  }
}

class SigninLogo extends StatelessWidget {
  const SigninLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: SvgPicture.asset(
            'assets/logos/logo_sip.svg',
            width: 80,
            height: 80,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: SvgPicture.asset(
            'assets/logos/logo_sip_short_ko.svg',
            width: 62.1,
            height: 29.61,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 36),
          child: SvgPicture.asset(
            'assets/logos/logo_sip_long_ko.svg',
            width: 146.82,
            height: 13.08,
          ),
        ),
      ],
    );
  }
}



class SigninForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  SigninForm();

  // TODO: 네이버 로그인 버튼 클릭 시 동작 구현
  void signInWithNaver() async {
    final NaverLoginResult result = await FlutterNaverLogin.logIn();

    print('Naver Login Result: $result');

    if (result.status == NaverLoginStatus.loggedIn) {
      print('accessToken = ${result.accessToken}');
      print('id = ${result.account.id}');
      print('email = ${result.account.email}');
      print('name = ${result.account.name}');


    }
  } //async 끝

  void naverLogin(BuildContext context, WidgetRef ref) async {
    try {

      await ref.read(authProvider.notifier);
      final NaverLoginResult user = await FlutterNaverLogin.logIn();
      NaverAccessToken res = await FlutterNaverLogin.currentAccessToken;



      String id = user.account.email;
      String name = user.account.name;
      String tel = user.account.mobile
          .replaceAll('+82', '0')
          .replaceAll('-', '')
          .replaceAll(' ', '')
          .replaceAll('+', '');
      String sex = user.account.gender;
      String socialNo = '${user.account.birthyear}${user.account.birthday}'.replaceAll('-', '');
      String idx = user.account.id.toString();

      print('$id,$name,$tel,$sex,$socialNo, $idx');
    } catch (error) {
      print('naver login error $error');
    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              '아이디',
              style: TextStyle(
                color: SECTION_FONT_COLOR,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SigninEmailInput(),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              '비밀번호',
              style: TextStyle(
                color: GRAY_COLOR_FONT,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SigninPasswordInput(),
          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 20),
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Future.delayed(Duration.zero, () async {
                  await ref.read(authProvider.notifier).checkTokenSplash(context);
                });
                Future.delayed(Duration.zero, () async {
                  await ref.read(signinProvider.notifier).onSignin(context);
       
                });
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(fontSize: 20),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 4),
                    child: const Text(
                      '로그인',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 48,
            margin: const EdgeInsets.only(bottom: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: 회원가입 버튼 클릭 시 동작 구현
                      context.go(PATH_SIGNUP);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.black12),
                    ),
                    child: const Text(
                      '회원가입',
                      style: TextStyle(
                        color: TEXT_PRIMARY_COLOR,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: 아이디/비밀번호 찾기 버튼 클릭 시 동작 구현
                      context.go(PATH_FINDIDPW);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      side: const BorderSide(width: 1.0, color: Colors.black12),
                    ),
                    child: const Text(
                      '비밀번호 찾기',
                      style: TextStyle(
                        color: TEXT_PRIMARY_COLOR,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 네이버 로그인
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 20),
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState != null) {
                  signInWithNaver();
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon_naver_login.svg',
                    width: 20,
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: const Text(
                      '네이버 로그인',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 카카오 로그인
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 20),
            height: 48,
            child: ElevatedButton(
              onPressed: () async {
                try {


                  bool isInstalled = await isKakaoTalkInstalled();

                  OAuthToken token = isInstalled
                      ? await UserApi.instance.loginWithKakaoTalk()
                      : await UserApi.instance.loginWithKakaoAccount();

                  final url = Uri.http('ship-dev.ap-northeast-2.elasticbeanstalk.com', '/api/v1/member/signup');

                  // final response = await http.post(
                  //   url,
                  //   headers: {
                  //     HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
                  //   },
                  // );
                  //
                  // final profileInfo = json.decode(response.body);
                  // print(profileInfo.toString());
                  try {
                    OAuthToken token =
                    await UserApi.instance.loginWithKakaoAccount();
                    print('카카오계정으로 로그인 성공 ${token.accessToken}');
                    final response = await http.post(
                      url,
                      headers: {
                        HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
                      },
                    );
                    print('카카오계정으로 로그인 성공1 ${response}');
                  } catch (error) {
                    print('카카오계정으로 로그인 실패 $error');
                  }
                  // 카카오 로그인 성공 후 추가 작업을 수행하십시오.
                  context.go(PATH_HOME);
                } catch (error) {
                  print('카카오톡으로 로그인 실패 $error');
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                backgroundColor: Colors.yellow,
                minimumSize: const Size(double.infinity, 0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/icon_kakao_login.svg',
                    width: 18,
                    height: 18,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: const Text(
                      '카카오 로그인',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: BLACK_FONT_COLOR_1C,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 애플 로그인
          if (Theme.of(context).platform == TargetPlatform.iOS) ...[
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(bottom: 20),
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState != null) {
                    // TODO: 애플 로그인 버튼 클릭 시 동작 구현



                    // 클릭 시 애플 로그인 프로바이더의 상태 업데이트
                    final result =
                    await SignInWithApple.getAppleIDCredential(
                      scopes: [
                        AppleIDAuthorizationScopes.email,
                        AppleIDAuthorizationScopes.fullName,

                      ],
                      webAuthenticationOptions: WebAuthenticationOptions(
                        clientId: 'ioss.test.fluttersimple',
                        redirectUri: Uri.parse(
                            'http://ship-dev.ap-northeast-2.elasticbeanstalk.com/api/v1/oauth/apple'),
                      ),
                    );

                    print(result);

                    final signInWithAppleEndpoint = Uri(
                      scheme: 'http',
                      // host: 'wealthy-sedate-furniture.glitch.me',
                      // path: '/callbacks/sign_in_with_apple',
                      host: 'ship-dev.ap-northeast-2.elasticbeanstalk.com',
                      path: '/api/v1/oauth/apple',
                      queryParameters: <String, String>{
                        'code': result.authorizationCode,
                        if (result.givenName != null)
                          'firstName': result.givenName!,
                        if (result.familyName != null)
                          'lastName': result.familyName!,
                        if (result.state != null)
                          'state': result.state!,
                      },
                    );

                    //int value = int.parse(signInWithAppleEndpoint as String, radix: 16);
                    final session = await http.Client().post(
                      signInWithAppleEndpoint,
                    );
                    // // 예시로 서버로 데이터를 POST하는 방법입니다.
                    // final response = await http.post(
                    //   Uri.parse('http://ship-dev.ap-northeast-2.elasticbeanstalk.com/api/v1/oauth/apple'),
                    //   body: {
                    //     'userIdentifier': AppleIDAuthorizationScopes.email,
                    //     'email':  AppleIDAuthorizationScopes.fullName,
                    //     // 필요한 다른 사용자 정보를 여기에 추가할 수 있습니다.
                    //   },
                    // );
                    context.go(PATH_HOME);
                    print(session);

                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/icon_apple_login.svg',
                      width: 19,
                      height: 19,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const Text(
                        '애플 로그인',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }


}
