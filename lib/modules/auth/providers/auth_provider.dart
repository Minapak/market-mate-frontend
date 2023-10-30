
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/auth/models/auth_model.dart';
import 'package:sip_app/modules/auth/repositories/auth_repository.dart';
import 'package:sip_app/modules/common/providers/dio_provider.dart';
import 'package:sip_app/modules/common/providers/secure_provider.dart';
import 'package:sip_app/utils/jwt.dart';

final checkLoggedInProvider = StateProvider<bool>((ref){
  return false;
});

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthModel>((ref) {
  final Dio dio = ref.watch(dioProvider);
  final AuthRepository repository = AuthRepository(dio, baseUrl: SERVER_BASE_URL);
  final notifier = AuthStateNotifier(ref: ref, repository:repository);

  return notifier;
});

final accessTokenProvider = StateProvider<String?>((ref) {
  // 여기에서 초기 값으로 null을 설정할 수 있습니다.
  return null;
});

final xerkProvider = StateProvider<String?>((ref) {
  // 여기에서 초기 값으로 null을 설정할 수 있습니다.
  return null;
});

class AuthStateNotifier extends StateNotifier<AuthModel> {
  final ref;
  final AuthRepository repository;
  AuthStateNotifier({required this.ref, required this.repository})
      : super(AuthModel(identyKey: '', userUUID: '', role: null));

  // 스플레쉬 화면에서 토큰이 있는지 검증
  // 토큰이 있으면 토큰 재발급 api 호출
  // 에러나면 로그인 안된유저로 처리
  // 성공하면 로그인상태 유지
  Future<void> checkTokenSplash(BuildContext context) async {
    print('checkTokenSplash');
    try {
      print('accessToken1');
      final storage = ref.read(secureStorageProvider);

      // Check if accessToken is issued
      final String? accessToken = await storage.read(key: ACCESS_TOKEN_KEY) ?? null;
      if (accessToken != null) {
        print('accessToken is issued: $accessToken');
      } else {
        print('accessToken is not issued');
      }
      final String? xerk = await storage.read(key: XERK_TOKEN_KEY) ?? null;

      print('accessToken????: $accessToken');
      print('xerk???: $xerk');

// If accessToken is issued, try refreshing it
      if (accessToken != null) {
        final res = await repository.refreshToken();
        print('res ㄹㅣ프레시: $res');
        if (res.success && res.response.accessToken != null && res.response.xerk != null) {
          print('Token refresh succeeded. New accessToken: ${res.response.accessToken}');
          // ...
        } else {
          print('Token refresh failed');
          // ...
        }
      }
      final accessTokenProvider = StateProvider<String?>((ref) {
        // 여기에서 초기 값으로 null을 설정할 수 있습니다.
        return null;
      });
      final xerkProvider = StateProvider<String?>((ref) {
        // 여기에서 초기 값으로 null을 설정할 수 있습니다.
        return null;
      });
      if (accessToken == null || xerk == null) {
        print('로그인 안된 유저');
        //로그인 안된 유저
        context.go(PATH_HOME);
        return;
      } else {
        print('로그인 가능성 잇음');
        // 로그인 가능성 있음
        // 토큰 재발급

        final res = await repository.refreshToken();
        print('res????: $res');
        if (res.success && res.response.accessToken != null && res.response.xerk != null) {
          print('토큰 재발급 성공');
          // 토큰 재발급 성공
          // 로그인한 유저로 등록
          setAuthModel(accessToken: res.response.accessToken);
          // 스토리지 새 토큰으로 저장
          await storage.write(key: ACCESS_TOKEN_KEY, value: res.response.accessToken);
          await storage.write(key: XERK_TOKEN_KEY, value: res.response.xerk);

          // accessTokenProvider 및 xerkProvider를 업데이트
          ref.read(accessTokenProvider).state = res.response.accessToken;
          ref.read(xerkProvider).state = res.response.xerk;

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
      print('$error  : 400?');
      ref.read(checkLoggedInProvider.notifier).state = false;
      context.go(PATH_HOME);
    }
  }
  // 스플레쉬 화면에서 토큰이 있는지 검증
  // 토큰이 있으면 토큰 재발급 api 호출
  // 에러나면 로그인 안된유저로 처리
  // 성공하면 로그인상태 유지
  Future<void> checkToken(BuildContext context) async {
    print('checkToken');
    try {
      print('accessToken1');
      final storage = ref.read(secureStorageProvider);

      // Check if accessToken is issued
      final String? accessToken = await storage.read(key: ACCESS_TOKEN_KEY) ?? null;
      if (accessToken != null) {
        print('accessToken is issued: $accessToken');
      } else {
        print('accessToken is not issued');
      }
      final String? xerk = await storage.read(key: XERK_TOKEN_KEY) ?? null;

      print('accessToken????: $accessToken');
      print('xerk???: $xerk');

// If accessToken is issued, try refreshing it
      if (accessToken != null) {
        final res = await repository.refreshToken();
        print('res ㄹㅣ프레시: $res');
        if (res.success && res.response.accessToken != null && res.response.xerk != null) {
          print('Token refresh succeeded. New accessToken: ${res.response.accessToken}');
          // ...
        } else {
          print('Token refresh failed');
          // ...
        }
      }
      final accessTokenProvider = StateProvider<String?>((ref) {
        // 여기에서 초기 값으로 null을 설정할 수 있습니다.
        return null;
      });
      final xerkProvider = StateProvider<String?>((ref) {
        // 여기에서 초기 값으로 null을 설정할 수 있습니다.
        return null;
      });
      if (accessToken == null || xerk == null) {
        print('로그인 안된 유저');
        //로그인 안된 유저
        context.go(PATH_HOME);
        return;
      } else {
        print('로그인 가능성 잇음');
        // // 로그인 가능성 있음
        // // 토큰 재발급
        //
        // final res = await repository.refreshToken();
        // print('res????: $res');
        // if (res.success && res.response.accessToken != null && res.response.xerk != null) {
        //   print('토큰 재발급 성공');
        //   // 토큰 재발급 성공
        //   // 로그인한 유저로 등록
        //   setAuthModel(accessToken: res.response.accessToken);
        //   // 스토리지 새 토큰으로 저장
        //   await storage.write(key: ACCESS_TOKEN_KEY, value: res.response.accessToken);
        //   await storage.write(key: XERK_TOKEN_KEY, value: res.response.xerk);
        //
        //   // accessTokenProvider 및 xerkProvider를 업데이트
        //   ref.read(accessTokenProvider).state = res.response.accessToken;
        //   ref.read(xerkProvider).state = res.response.xerk;
        //
        //   ref.read(checkLoggedInProvider.notifier).state = true;
        // } else {
        //   print('토큰 재발급 실패');
        //   // 토큰 재발급 실패
        //   // 만료된 토큰, xerk로 최종 로그인 안되어있음.
        //   ref.read(checkLoggedInProvider.notifier).state = false;
        //
        //   await storage.delete(key: ACCESS_TOKEN_KEY);
        //   await storage.delete(key: XERK_TOKEN_KEY);
        // }
      }
      context.go(PATH_HOME);
    } catch(error) {
      print('에러입니다');
      print('$error  : 400?');
      ref.read(checkLoggedInProvider.notifier).state = false;
      context.go(PATH_HOME);
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

      final storage = ref.read(secureStorageProvider);

      await storage.delete(key: ACCESS_TOKEN_KEY);
      await storage.delete(key: XERK_TOKEN_KEY);

      ref.read(checkLoggedInProvider.notifier).state = false;
      print('로그아웃 성공');
    } catch (error) {
      print('로그아웃 에러');
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


// authModel
// memberModel
// storageModel
//todo
// auth model이 변경이 되면 listen 하고 있다가 변경이 되는 changeNotifierProvider가 있어야 함.
// 만약 로그인이 안되어 있는데 유저의 행동을 시도 할 시 로그인 페이지 이동 후 로그인 하고 리다이렉트 시켜준다.
// 유저 정보를 불러오는 api에서 expert랑 wholesaler 다 받아옴
// 로그아웃 두가지 방법
// auth model이 변경이 되면 listen 하고 있다가 변경이 되는 changeNotifierProvider가 있어야 함. 1번째 방법
// 맴버 provider에서 로그아웃을 하고 authmodel에서 changeNotifierProvider를 통해서 리다이렉트 시켜주는거지. 두번째방법
//wholesaler, expert 이 두개의 룰이 있잖아.
// authModel 의 role이 expert이면
// wholesaler 의 role이 wholesaler
// 최근 유저의 롤이 뭐였는지 storage에 같이 저장하자.
// 만약 최근 role 이 expert라면,
// expert 전용화면에서 api요청해야함
// expert 정보, 유저 정보가 필요함
// 그냥 유저 정보 불러오는 api에서 expert 랑 wholesaler 다 달라고 하자.
// 그러면 member model에서 다 같이 관리할수있어
// 여기까지 구현해야함. - 서울역 카페

// provider가 너무 흩어져 있다.
// 이걸 어떻게 관리 할 수 있지않을까?
// FutureProvider보다는 StateNotifierProvider를 쓰는게 더 낫지 않을까?
//