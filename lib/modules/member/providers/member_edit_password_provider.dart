
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/member/models/member_model.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';
import 'package:sip_app/modules/member/repositories/member_repository.dart';

// 비밀번호 ui provider
final memberEditPasswordViewProvider = StateProvider.autoDispose<String>((ref) {
  return EMPTY_STRING;
});

// 비밀번호확인 ui provider
final memberEditPasswordVerifyViewProvider = StateProvider.autoDispose<String>((ref) {
  return EMPTY_STRING;
});

// 비밀번호 변경 api provider
final MemberEditPasswordNotifierProvider = StateNotifierProvider.autoDispose
<MemberEditPasswordNotifier, ServerStatusBase>((ref) {
  final Dio dio = Dio();
   final repository = MemberRepository(dio, baseUrl: '$SERVER_BASE_URL/members/');
  final String uuid = ref.watch(memberUUIDProvider);

  final password = ref.watch(memberEditPasswordViewProvider);
  final passwordVerify = ref.watch(memberEditPasswordVerifyViewProvider);

  final notifier = MemberEditPasswordNotifier(
    repository: repository,
    userUUID: uuid,
    password: password,
    passwordVerify: passwordVerify,
  );

  return notifier;
});


// 비밀번호 변경 api notifier
class MemberEditPasswordNotifier extends StateNotifier<ServerStatusBase> {
  final String userUUID;
  final MemberRepository repository;
  final String password;
  final String passwordVerify;

  MemberEditPasswordNotifier({
    required this.userUUID,
    required this.repository,
    required this.password,
    required this.passwordVerify,
  })
    : super(ServerStatusInitial());

  Future<void> onSubmit() async {
    try {
      state = ServerStatusLoading();

      final UpdateMemberModel data = UpdateMemberModel(
          password: password,
          passwordVerify:passwordVerify
      );

      final res = await repository.updateMember(id: userUUID, data: data);

      if (!res.success) {
        state = ServerStatusError(message: '서버 에러');
      }

      state = ServerStatusSuccess();
    } catch(error) {
      print(error);
      state = ServerStatusError(message: '서버 에러');
    }
  }
}