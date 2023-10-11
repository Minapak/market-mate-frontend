import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/member/models/member_model.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';
import 'package:sip_app/modules/member/repositories/member_repository.dart';

// 닉네임 변경 UI
final memberEditNicknameViewProvider = StateProvider<String>((ref) {
  return EMPTY_STRING;
});

// 닉네임 변경 API 요청 provider
final memberEditNicknameProvider = StateNotifierProvider.autoDispose((ref) {
  final Dio dio = Dio();

  final repository = MemberRepository(dio, baseUrl: '$SERVER_BASE_URL/members/');
  final String uuid = ref.watch(memberUUIDProvider);

  final notifier = MemberEditNicknameStateNotifier(
      repository: repository, userUUID: uuid, ref: ref
  );

  return notifier;
});

// 닉네임 변경 API 요청 notifier
class MemberEditNicknameStateNotifier extends StateNotifier<ServerStatusBase> {
  final String userUUID;
  final MemberRepository repository;
  final ref;

  MemberEditNicknameStateNotifier({
    required this.ref,
    required this.userUUID,
    required this.repository
  }): super(ServerStatusInitial());

  // 에러 후 재시도
  void retry() {
    state = ServerStatusInitial();
  }

  // 닉네임 변경 API 요청
  Future<void> onSubmit(String nickname) async {
    try {
      // todo: validation 해야함
      state = ServerStatusLoading();
      final UpdateMemberModel data = UpdateMemberModel(nickname: nickname);
      final res = await repository.updateMember(id: userUUID, data: data);

      if (!res.success) {
        state = ServerStatusError(message: '서버 에러입니다.');
        return;
      }
      final newNickname = res.response.nickname;
      // 기존 맴버 데이터 변경
      ref.read(memberNotifierProvider.notifier).updateNickname(newNickname:newNickname);

      state = ServerStatusSuccess();
    } catch(error ){
      log('error:$error');
     state = ServerStatusError(message: '서버 에러입니다.');
    }
  }
}