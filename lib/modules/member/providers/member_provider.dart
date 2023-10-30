import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/member/models/member_model.dart';
import 'package:sip_app/modules/auth/providers/auth_provider.dart';
import 'package:sip_app/modules/member/repositories/member_repository.dart';



//현재 사용자의 UUID를 제공하는 프로바이더
//사용자가 인증되지 않은 경우 예외를 throw
final memberUUIDProvider = Provider<String>((ref) {
  final asyncMemberState = ref.watch(memberNotifierProvider);

  return asyncMemberState.maybeWhen(
      data: (member) {
        if (member.uuid == null) {
          throw Exception('User is not authenticated.member.uuid == null');
        }
        return member.uuid!;
      },
      orElse: () => throw Exception('User is not authenticated.')
  );
});

//유저 정보 저장 Notifier
//사용자 정보를 저장하고 업데이트하는 MemberStateNotifier를 생성하는 프로바이더
//사용자 정보에 대한 변경사항은 MemberStateNotifier를 통해 관리
final memberNotifierProvider =
    StateNotifierProvider<MemberStateNotifier, AsyncValue<MemberModel>>((ref) {
  final Dio dio = Dio();


  final MemberRepository repository =
      MemberRepository(dio, baseUrl: '$SERVER_BASE_URL/members ');

  final userModel = ref.watch(memberFutureProvider);
  final notifier = MemberStateNotifier(repository: repository, user: userModel);

  return notifier;
});

//유저 정보 저장하는 classNotifier
class MemberStateNotifier extends StateNotifier<AsyncValue<MemberModel>> {
  final MemberRepository repository;

  MemberStateNotifier(
      {required this.repository, required AsyncValue<MemberModel> user})
      : super(user);

  void updateNickname({required String newNickname}) async {
    if (state is AsyncData<MemberModel>) {
      var oldData = (state as AsyncData<MemberModel>).value;
      final updatedData = oldData.copyWith(nickname: newNickname);
      state = AsyncValue.data(updatedData);
    } else {
      throw Exception('Cannot update member because the current state does not contain data.');
    }
  }

  void updateImage({required String newImagePath}) async {
    if (state is AsyncData<MemberModel>) {
      var oldData = (state as AsyncData<MemberModel>).value;
      final updatedData = oldData.copyWith(thumbnail: newImagePath);
      state = AsyncValue.data(updatedData);
    } else {
      throw Exception('Cannot update member because the current state does not contain data.');
    }
  }
}

// 맴버 정보 받아옴
final memberFutureProvider = FutureProvider<MemberModel>((ref) async {
  try {
    final Dio dio = Dio();

    final MemberRepository repository =
        MemberRepository(dio, baseUrl: '$SERVER_BASE_URL/members');
    final authModel = ref.watch(authProvider);
    print(authModel.userUUID);
    final res = await repository.getMember(id: authModel.userUUID ?? '');

    return res.response;
  } catch (error) {
    print(error);
    throw Exception("Failed to fetch User");
  }
});
