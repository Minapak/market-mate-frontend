

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/expert/providers/experts_provider.dart';
import 'package:sip_app/modules/expert/providers/experts_upload_image_provider.dart';

import '../../member/providers/member_provider.dart';
import '../models/expert_register_model.dart';
import '../repositories/expert_repository.dart';
import 'expert_detail_provider.dart';
import 'experts_upload_intro_detail_provider.dart';

final ExpertRegisterSubmitProvider = StateNotifierProvider.family
<ExpertRegisterSubmitStateNotifier, ServerStatusBase, int>((ref, expertId) {
  final Dio dio = Dio();


  final userUUID = ref.watch(memberUUIDProvider);
  final repository = ExpertRepository(dio, baseUrl: '$SERVER_BASE_URL/users/$userUUID/expert');
  final notifier = ExpertRegisterSubmitStateNotifier(ref: ref,repository: repository, userUUID: userUUID, expertId: expertId);

  return notifier;
});

class ExpertRegisterSubmitStateNotifier extends StateNotifier<ServerStatusBase> {
  final ref;
  final String userUUID;
  final ExpertRepository repository;
  final int expertId;

  ExpertRegisterSubmitStateNotifier({required this.ref ,required this.expertId, required this.userUUID, required this.repository}): super(ServerStatusInitial()){
    onSubmit();
  }


  Future<void> onSubmit() async{
    print(ref.read(expertCacheProvider).id);
    print(ref.read(ExpertUploadDetailProvider).thumnail);
    print(ref.read(ExpertUploadDetailProvider).introduceExpert);
    print(ref.read(ExpertUploadDetailProvider).introduceContent);
    print(ref.read(ExpertUploadImageProvider).email);
    print(ref.read(expertListProvider).CroppedFile);

    try {
      final ExpertRegisterModel data = ExpertRegisterModel(
        id: ref.read(expertCacheProvider).id,
        thumbnail: ref.read(ExpertUploadDetailProvider).thumbnail,
        introduceExpert: ref.read(ExpertUploadDetailProvider).introduceExpert,
        introduceContent: ref.read(ExpertUploadDetailProvider).introduceContent,
        images: ref.read(ExpertUploadImageProvider).images,
        mainCategories: ref.read(expertListProvider).mainCategories,
        middleCategories: ref.read(expertListProvider).middleCategories,
      );

      final res =  await repository.ExpertsRegister(id: expertId, data: data);
      print(res);
      if (res.success){
        print('success');
        state = ServerStatusSuccess();
      } else {
        print('dpfj');
        state = ServerStatusError(message: '에러');
      }

    } catch(error) {
      print(error);
      state = ServerStatusError(message: '에러');
    }
  }

}