///Dio는 Dart 언어를 기반으로 작성된 HTTP 클라이언트 라이브러리
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/auth/models/signin_model.dart';
import 'package:sip_app/modules/auth/models/auth_model.dart';
import 'package:sip_app/modules/auth/models/auth_token_model.dart';
import 'package:sip_app/modules/auth/providers/auth_provider.dart';
import 'package:sip_app/modules/auth/providers/signin_email_provider.dart';
import 'package:sip_app/modules/auth/providers/signin_password_provider.dart';
import 'package:sip_app/modules/auth/repositories/auth_repository.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/common/providers/dio_provider.dart';
import 'package:sip_app/modules/common/providers/secure_provider.dart';

final checkLoggedInProvider = StateProvider<bool>((ref) {
  final storage = ref.watch(secureStorageProvider);
  final accessToken = storage.read(key: ACCESS_TOKEN_KEY);

  // 액세스 토큰이 있는 경우, 사용자가 로그인되어 있는 것으로 간주
  return accessToken != null;
});
/// signinProvider는 Riverpod 패키지의 StateNotifierProvider를 사용하여 상태를 관리하는 provider
final signinAppleProvider = StateNotifierProvider.autoDispose<SigninStateNotifier, ServerStatusBase>((ref) {
  final Dio dio = ref.watch(dioProvider);
  final AuthRepository repository = AuthRepository(dio, baseUrl: SERVER_BASE_URL);
  final notifier = SigninStateNotifier(repository: repository, ref: ref);

  return notifier;
});

///SigninStateNotifier 클래스는 상태 관리와 로그인 작업을 처리하는 클래스
class SigninStateNotifier extends StateNotifier<ServerStatusBase>{
  // ref와 repository를 인자로 받음
  // ref는 Riverpod provider에 대한 참조이며,
  // repository는 API 호출을 관리하는 AuthRepository 클래스의 인스턴스
  final ref;
  final AuthRepository repository;

  SigninStateNotifier({required this.ref, required this.repository})
      : super(ServerStatusInitial());

  ///onSignin 메서드는 사용자가 로그인 버튼을 눌렀을 때 실행
  Future<void> onSignin(BuildContext context) async {
    try {
      //로그인 동작을 수행하기 전에 상태를 ServerStatusLoading()으로 변경하여 로딩 중임 알림
      state = ServerStatusLoading();

      //사용자가 입력한 이메일과 비밀번호를 SigninModel에 저장
      final data = SigninModel(
        identyKey: ref.read(signinEmailProvider).email,
        password: ref.read(signinPasswordProvider).password,
      );
      /// 로그인 호출
      // repository.signin(data: data)를 호출하여 서버에 로그인 요청 보내기
      final res = await repository.signin(data: data);


      // 응답이 실패하면 ServerStatusError 상태로 변경하고 에러 메시지를 표시
      if (res.success == false) {
        state = ServerStatusError(message: '서버 상태 에러');
        return;
      }
      /// 토큰 저장
      // 성공적으로 로그인한 경우, 서버에서 받은 액세스 토큰과 기타 정보를 저장
      //secureStorageProvider를 사용하여 액세스 토큰과 XERK 토큰을 안전하게 저장
      final storage = ref.read(secureStorageProvider);

      await storage.write(key: ACCESS_TOKEN_KEY, value: res.response.accessToken);
      await storage.write(key: XERK_TOKEN_KEY, value: res.response.xerk);

      /// authProvider를 사용하여 사용자 인증 모델을 업데이트
      //사용자의 로그인 상태를 관리하는 데 사용
      ref.read(authProvider.notifier).setAuthModel(accessToken: res.response.accessToken);

      if (Theme.of(context).platform == TargetPlatform.iOS) {
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'ioss.test.fluttersimple',
            redirectUri: Uri.parse(
                'https://wealthy-sedate-furniture.glitch.me/callbacks/sign_in_with_apple'),
          ),
        );
        final identityToken = appleCredential.identityToken;

        // authProvider를 사용하여 사용자 인증 모델을 업데이트
        ref.read(authProvider.notifier).setAuthModel(
          appleIdentityToken: identityToken,
        );
      }



      ///로그인 성공
      state = ServerStatusSuccess();
      ///성공 시, 홈 화면 이동
      context.go(PATH_HOME);

      ///Dio 패키지의 DioException을 catch하여 네트워크 오류를 처리
    } on DioException catch(error) {
      print(error);
      state = ServerStatusError(message: '에러');
    }
  }
}