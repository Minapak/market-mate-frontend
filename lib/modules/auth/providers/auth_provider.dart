import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/auth/models/auth_model.dart';
import 'package:sip_app/modules/auth/screens/onboarding_screen.dart';
import 'package:sip_app/modules/auth/repositories/auth_repository.dart';
import 'package:sip_app/modules/common/providers/dio_provider.dart';
import 'package:sip_app/modules/common/providers/secure_provider.dart';
import 'package:sip_app/utils/jwt.dart';

final checkLoggedInProvider = StateProvider<bool>((ref) {
  return false;
});

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthModel>((ref) {
  final Dio dio = ref.watch(dioProvider);
  final AuthRepository repository = AuthRepository(dio, baseUrl: SERVER_BASE_URL);
  final notifier = AuthStateNotifier(ref: ref, repository: repository);

  return notifier;
});

class AuthStateNotifier extends StateNotifier<AuthModel> {
  final ref;
  final AuthRepository repository;
  AuthStateNotifier({required this.ref, required this.repository})
      : super(AuthModel(identyKey: '', userUUID: '', role: null));

  // 스플레쉬 화면에서 토큰이 있는지 검증
  // 토큰이 있으면 토큰 재발급 api 호출
  /// 에러나면 로그인 안된 유저로 처리
  /// 성공하면 로그인상태 유지
  Future<void> checkTokenSplash(BuildContext context) async {
    print('checkTokenSplash');
    bool _shouldNavigateToOnBoarding;
    try {
      print('accessToken1');
      final storage = ref.read(secureStorageProvider);

      final String? accessToken = await storage.read(key: ACCESS_TOKEN_KEY) ?? null;
      final String? xerk = await storage.read(key: XERK_TOKEN_KEY) ?? null;

      if (accessToken == null || xerk == null) {
        print('로그인 안된 유저');

        context.go(PATH_HOME);
        return;
      } else {
        print('로그인 가능성 있음');
        // 로그인 가능성 있음
        // 토큰 재발급
        final res = await repository.refreshToken();

        if (res.success && res.response.accessToken != null && res.response.xerk != null) {
          print('토큰 재발급 성공');
          // 토큰 재발급 성공
          // 로그인한 유저로 등록
          setAuthModel(accessToken: res.response.accessToken);
          // 스토리지 새 토큰으로 저장
          await storage.write(key: ACCESS_TOKEN_KEY, value: res.response.accessToken);
          await storage.write(key: XERK_TOKEN_KEY, value: res.response.xerk);

          ref.read(checkLoggedInProvider.notifier).state = true;
        } else {
          print('토큰 재발급 실패');
          // 토큰 재발급 실패
          // 만료된 토큰, xerk로 최종 로그인 안되어있음.
          ref.read(checkLoggedInProvider.notifier).state = false;

          await storage.delete(key: ACCESS_TOKEN_KEY);
          await storage.delete(key: XERK_TOKEN_KEY);
        }
      }

     context.go(PATH_HOME);
    } catch(error) {
      print('에러입니다');
      print(error);
      ref.read(checkLoggedInProvider.notifier).state = false;
    //TODO: 에러 페이지 만들기
      context.go(PATH_MYPAGE);

    }
  }

  // 로그아웃
  Future<void> onLogout() async {
    try {
      state = AuthModel(
        identyKey: '',
        userUUID: '',
        role: null,
      );

      // 토큰 삭제
      final storage = ref.read(secureStorageProvider);

      await storage.delete(key: ACCESS_TOKEN_KEY);
      await storage.delete(key: XERK_TOKEN_KEY);

      ref.read(checkLoggedInProvider.notifier).state = false;
      print('success');
    } catch(error) {

      print(error);
    }
  }

  void setAuthModel({required String accessToken}) {
    print('setAuthModel');
    print('accessToken: $accessToken');
    final authModel = parseJwt(accessToken);

    if (authModel.identyKey != null && authModel.userUUID != null) {
      ref.read(checkLoggedInProvider.notifier).state = true;
      print('authmodel:$authModel');
      state = authModel;
    }
  }
}