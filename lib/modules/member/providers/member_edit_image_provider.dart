import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';
import 'package:sip_app/modules/member/repositories/member_repository.dart';

final memberEditImageViewProvider = StateProvider<CroppedFile?>((ref){
  return null;
});

final memberEditImageNotifierProvider = StateNotifierProvider
<MemberEditImageNotifier, ServerStatusBase>((ref) {
  print('memberEditImageNotifierProvider');
  final Dio dio = Dio();

  final repository = MemberRepository(dio, baseUrl: '$SERVER_BASE_URL/members/');

  final croppedFile = ref.watch(memberEditImageViewProvider);

  final String uuid = ref.watch(memberUUIDProvider);

  final notifier = MemberEditImageNotifier(
    ref: ref,
    repository: repository,
    userUUID: uuid,
    croppedFile: croppedFile,
  );

  return notifier;
});


class MemberEditImageNotifier extends StateNotifier<ServerStatusBase> {
  final ref;
  final String userUUID;
  final CroppedFile? croppedFile;
  final MemberRepository repository;

  MemberEditImageNotifier({required this.ref,this.croppedFile, required this.repository, required this.userUUID})
      :super(ServerStatusInitial());

  Future<void> onSubmit() async {
    state = ServerStatusLoading();

    try {
      if (croppedFile != null) {
        final file = File(croppedFile!.path!);
        final res = await repository.updateImage(id: userUUID, image: file!);

        if (!res.success) {
          state = ServerStatusError(message: '서버 에러');
        }

        ref.read(memberNotifierProvider.notifier)
            .updateImage(newImagePath: res.response.thumbnail);

        state = ServerStatusSuccess();
      }
    } catch(error) {
      print(error);
      state = ServerStatusError(message: '서버 에러');
    }
  }
}