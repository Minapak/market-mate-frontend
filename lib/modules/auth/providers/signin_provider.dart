import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/auth/models/signin_model.dart';
import 'package:sip_app/modules/auth/providers/auth_provider.dart';
import 'package:sip_app/modules/auth/providers/signin_email_provider.dart';
import 'package:sip_app/modules/auth/providers/signin_password_provider.dart';
import 'package:sip_app/modules/auth/repositories/auth_repository.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/common/providers/dio_provider.dart';
import 'package:sip_app/modules/common/providers/secure_provider.dart';

final signinProvider = StateNotifierProvider.autoDispose<SigninStateNotifier, ServerStatusBase>((ref) {
  final Dio dio = ref.watch(dioProvider);
  final AuthRepository repository = AuthRepository(dio, baseUrl: SERVER_BASE_URL);
  final notifier = SigninStateNotifier(repository: repository, ref: ref);

  return notifier;
});

class SigninStateNotifier extends StateNotifier<ServerStatusBase>{
  final ref;
  final AuthRepository repository;

  SigninStateNotifier({required this.ref, required this.repository})
      : super(ServerStatusInitial());

  Future<void> onSignin(BuildContext context) async {
    try {
      state = ServerStatusLoading();

      final data = SigninModel(
        identyKey: ref.read(signinEmailProvider).email,
        password: ref.read(signinPasswordProvider).password,
      );

      final res = await repository.signin(data: data);

      if (res.success == false) {
        state = ServerStatusError(message: '에러');
        return;
      }
      // 토큰 저장
      final storage = ref.read(secureStorageProvider);

      await storage.write(key: ACCESS_TOKEN_KEY, value: res.response.accessToken);
      await storage.write(key: XERK_TOKEN_KEY, value: res.response.xerk);

      // auth provider에 저장
      ref.read(authProvider.notifier).setAuthModel(accessToken: res.response.accessToken);

      state = ServerStatusSuccess();

      context.go(PATH_HOME);
    } on DioException catch(error) {
      print(error);
      state = ServerStatusError(message: '에러');
    }
  }
}