// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:sip_app/constants/path.dart';
// import 'package:sip_app/modules/common/models/server_status_model.dart';
// import 'package:sip_app/modules/member/providers/member_provider.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../repositories/expert_repository.dart';
// import '../screens/experts_upload_image_screen.dart';
// import 'experts_register_provider.dart';
//
//
// // 이미지를 압축하고 업로드하기 위한 상태 공급자를 정의
// final ExpertsUploadImageViewProvider = StateProvider<CroppedFile?>((ref) {
//   return null;
// });
//
// // 이미지 업로드 상태 관리자를 정의
// final ExpertsUploadImageNotifierProvider = StateNotifierProvider<ExpertsUploadImageNotifier, ServerStatusBase>((ref) {
//   print('ExpertsUploadImageNotifierProvider');
//   final Dio dio = Dio();
//   print('dio1:'  '$dio');
//
//   // 선택한 이미지를 가져옴
//   final croppedFile = ref.watch(ExpertsUploadImageViewProvider);
//   print('croppedFile:'  '$ref.watch(memberEditImageViewProvider');
//   print('dio2:'  '$dio');
//   // 사용자 UUID 가져옴
//   final String uuid = ref.watch(memberUUIDProvider);
//   // 사용자 UUID 가져옴
//   final String exuuid = ref.watch(expertsIDProvider);
//   print('baseUrl:'  '$SERVER_BASE_URL/users/experts/$exuuid/images');
//   print('dio3:'  '$dio');
//   // 이미지 업로드를 위한 리포지토리 생성
//   final repository = ExpertRepository(dio, baseUrl: '$SERVER_BASE_URL/users/$exuuid/expert');
//
//   // 이미지 업로드 상태 관리자 생성
//   final notifier = ExpertsUploadImageNotifier(
//     ref: ref,
//     repository: repository,
//     userUUID: uuid,
//     expertUUID: exuuid,
//     croppedFile: croppedFile,
//   );
//
//   return notifier;
// });
//
// // 이미지 업로드를 처리하는 상태 관리자 클래스 정의
// class ExpertsUploadImageNotifier extends StateNotifier<ServerStatusBase> {
//   final ref;
//   final String userUUID;
//   final String expertUUID;
//   final CroppedFile? croppedFile;
//   final ExpertRepository repository;
//
//   ExpertsUploadImageNotifier({
//     required this.ref,
//     this.croppedFile,
//     required this.expertUUID,
//     required this.repository,
//     required this.userUUID,
//   }) : super(ServerStatusInitial());
//
//
//   // 이미지 업로드 시작
//   Future<void> onSubmit() async {
//     print('expertUploadImageNotifier_onSubmit()');
//     final Dio dio = Dio();
//     SharedPreferences userID = await SharedPreferences.getInstance();
//     userID.setString('userUUID', userUUID);
//     print('expertUploadNotifier_onSubmit()');
//     print('User ID: $userUUID');
//     print('expertUUID: $expertUUID');
//     // 이미지가 선택되었는지 확인
//     state = ServerStatusLoading();
//     // 이미지 압축
//     try {
//
//       final originalFilePath = croppedFile!.path!; // 원본 파일 경로
//       print('Original File Path: $originalFilePath');
//       if (croppedFile != null) {
//         final compressedFile = await FlutterImageCompress.compressAndGetFile(
//
//           croppedFile!.path!,
//           croppedFile!.path!.replaceAll('.jpg', '_compressed.jpg'), // 새 파일 경로
//           quality: 30, // 압축 품질 (1-100, 값이 작을수록 압축이 높음)
//         );
//         // 압축된 이미지 파일이 정상적으로 생성되었는지 확인
//         if (compressedFile == null) {
//           state = ServerStatusError(message: '이미지 압축 실패');
//           print('압축상태 1: $state');
//           return;
//         }
//         // 이미지 파일을 File 객체로 변환
//         final file = File(compressedFile.path);
//         print('압축상태 2: $state');
//         print('파일 객체 : $file');
//
//
//
//
//         // 이미지 서버 업로드 요청 보냄
//         final res = await repository.ExpertsUploadImage(userId: userUUID, expertId: exuuid, image: file);
//         print('res상태 : $res');
//
//
//         //쉐어드로 userUUID 저장 후 member_edit_image_view 에서 사용
//         print('Image Upload Response: $res'); // res를 로그로 출력
//         // 업로드 성공 여부 확인
//         if (!res.success) {
//           state = ServerStatusError(message: '서버 에러');
//           print('Image Upload Failed');
//         }
//         print('Image Upload Succeeded');
//         // 사용자 프로필 이미지 업데이트
//         ref.read(memberNotifierProvider.notifier).updateImage(newImagePath: res.response.thumbnail);
//         print('res.response.thumbnail : ${res.response.thumbnail}');
//         state = ServerStatusSuccess();
//       }
//     } catch (error) {
//       print(error);
//       state = ServerStatusError(message: '서버 에러');
//     }
//   }
// }
//
