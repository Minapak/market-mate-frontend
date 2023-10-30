// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sip_app/constants/path.dart';
// import 'package:sip_app/modules/expert/models/expert_model.dart';
// import 'package:sip_app/modules/expert/models/expert_register_model.dart';
// import 'package:sip_app/modules/auth/providers/auth_provider.dart';
// import 'package:sip_app/modules/expert/repositories/expert_repository.dart';
// import 'package:sip_app/modules/expert/providers/experts_register_provider.dart';
// import '../../common/models/image_model.dart';
//
//
//
// //현재 사용자의 UUID를 제공하는 프로바이더
// //사용자가 인증되지 않은 경우 예외를 throw
// final expertsIDProvider = Provider<String>((ref) {
//   final asyncExpertState = ref.watch(expertsNotifierProvider);
//
//   return asyncExpertState.maybeWhen(
//       data: (expert) {
//         if (expert.id == null) {
//           throw Exception('User is not authenticated.experts.uuid == null');
//         }
//         return expert.id.toString();
//       },
//       orElse: () => throw Exception('experts is not authenticated.')
//   );
// });
//
// //유저 정보 저장 Notifier
// //사용자 정보를 저장하고 업데이트하는 MemberStateNotifier를 생성하는 프로바이더
// //사용자 정보에 대한 변경사항은 MemberStateNotifier를 통해 관리
// final expertsNotifierProvider =
// StateNotifierProvider<ExpertStateNotifier, AsyncValue<ExpertModel>>((ref) {
//   final Dio dio = Dio();
//
//
//   final ExpertRepository repository =
//   ExpertRepository(dio, baseUrl: '$SERVER_BASE_URL/users/$expertsIDProvider/expert ');
//
//   final userModel = ref.watch(expertFutureProvider);
//   final notifier = ExpertStateNotifier(repository: repository, user: userModel);
//
//   return notifier;
// });
//
// //유저 정보 저장하는 classNotifier
// class ExpertStateNotifier extends StateNotifier<AsyncValue<ExpertModel>> {
//   final ExpertRepository repository;
//
//   ExpertStateNotifier(
//       {required this.repository, required AsyncValue<ExpertModel> user})
//       : super(user);
//
//   void updateIntroExpert({required String newIntroduceExpert}) async {
//     if (state is AsyncData<ExpertRegisterModel>) {
//       var oldData = (state as AsyncData<ExpertRegisterModel>).value;
//       final updatedData = oldData.copyWith(introduceExpert: newIntroduceExpert);
//       state = AsyncValue.data(updatedData as ExpertModel);
//     } else {
//       throw Exception('Cannot update member because the current state does not contain data.');
//     }
//   }
//
//   void updateIntroContent({required String newIntroduceContent}) async {
//     if (state is AsyncData<ExpertRegisterModel>) {
//       var oldData = (state as AsyncData<ExpertRegisterModel>).value;
//       final updatedData = oldData.copyWith(introduceExpert: newIntroduceContent);
//       state = AsyncValue.data(updatedData);
//     } else {
//       throw Exception('Cannot update member because the current state does not contain data.');
//     }
//   }
//
//   void updateThumbnail({required String newthumbnail}) async {
//     if (state is AsyncData<ExpertRegisterModel>) {
//       var oldData = (state as AsyncData<ExpertRegisterModel>).value;
//       final updatedData = oldData.copyWith(thumbnail: newthumbnail);
//       state = AsyncValue.data(updatedData);
//     } else {
//       throw Exception('Cannot update member because the current state does not contain data.');
//     }
//   }//업데이트 이미지 끝
//
//
//   void updateImages({required List<ImageModel>? newImages}) async {
//     if (state is AsyncData<ExpertRegisterModel>) {
//       var oldData = (state as AsyncData<ExpertRegisterModel>).value;
//       final updatedData = oldData.copyWith(images: newImages);
//       state = AsyncValue.data(updatedData);
//     } else {
//       throw Exception('Cannot update member because the current state does not contain data.');
//     }
//   }//업데이트 이미지 끝
//
//
// }
//
// // 맴버 정보 받아옴
// final expertFutureProvider = FutureProvider<ExpertRegisterModel>((ref) async {
//   try {
//     final Dio dio = Dio();
//
//     final ExpertRepository repository =
//     ExpertRepository(dio, baseUrl: '$SERVER_BASE_URL/users/$expertsIDProvider/expert');
//     final authModel = ref.watch(authProvider);
//     print(authModel.userUUID);
//     final res = await repository.getMember(id: authModel.userUUID ?? '');
//
//     return res.response;
//   } catch (error) {
//     print(error);
//     throw Exception("Failed to fetch User");
//   }
// });
