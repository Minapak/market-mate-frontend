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
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers["Authorization"] =
  "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0MTg1ZUBuYXZlci5jb20iLCJhdXRoIjoiUk9MRV9BRE1JTiIsInVzZXJVVUlEIjoiMmM5ZTgxYTk4ODc5YjNlMTAxODg3OWI1MzI5ZTAwMDAiLCJpZGVudHlLZXkiOiJ0ZXN0MTg1ZUBuYXZlci5jb20iLCJleHAiOjE2OTM1MjA2ODN9.M_vLns1fietL0m9VhhEuvQr7_9asmZioK7L3uRVNQSAik1vPrrjf3VBOChMo9iTUfyjT7nsu0fs-8HJY4-9KbA";
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