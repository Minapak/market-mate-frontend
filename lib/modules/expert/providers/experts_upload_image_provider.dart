
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/expert/providers/experts_provider.dart';
import 'package:sip_app/modules/expert/repositories/expert_repository.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';
import 'package:sip_app/modules/wishlist/models/response_check_wish_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'expert_detail_provider.dart';

// 이미지를 압축하고 업로드하기 위한 상태 공급자를 정의
final ExpertUploadImageProvider = StateProvider<List<XFile>>((ref) {
  List<XFile> images = <XFile>[];
  return images;
});

// 이미지 업로드 상태 관리자를 정의
final ExpertUploadImageNotifierProvider = StateNotifierProvider<ExpertUploadImageStateNotifier, ServerStatusBase>((ref) {
  print('ExpertUploadImageNotifierProvider');
  final Dio dio = Dio();
  print('dio1:'  '$dio');

  // 선택한 이미지 '여러장'를 가져옴
  final croppedFile = ref.watch(ExpertUploadImageProvider);
  print('croppedFile:'  '$ref.watch(ExpertUploadImageProvider');
  print('dio2:'  '$dio');
  // 사용자 UUID 가져옴
  final String uuid = ref.watch(memberUUIDProvider);
  print('baseUrl:'  '$SERVER_BASE_URL/members/$uuid/image');
  print('dio3:'  '$dio');
  // 사용자 UUID 가져옴
  final String parsedExpertId = ref.watch(expertCacheProvider as AlwaysAliveProviderListenable<String>);
  final int expertId = int.tryParse(parsedExpertId) ?? 0; // 0은 기본값
  print('expertId:'  '$expertId');
  print('dio4:'  '$dio');
  // 이미지 업로드를 위한 리포지토리 생성
  final repository = ExpertRepository(dio, baseUrl: '$SERVER_BASE_URL/users/experts/$expertId/images');

  // 이미지 업로드 상태 관리자 생성
  final notifier = ExpertUploadImageStateNotifier(
    ref: ref,
    repository: repository,
    userUUID: uuid,
    expertId: expertId,
  );

  return notifier;
});


class ExpertUploadImageStateNotifier extends StateNotifier<ServerStatusBase> {
  List<XFile> images = <XFile>[];

  final ref;
  final ExpertRepository repository;
  final String userUUID;
  final int expertId;

  ExpertUploadImageStateNotifier({
    required this.ref,
    required this.userUUID,
    required this.repository,
    required this.expertId,
  }) : super(ServerStatusInitial());


  Future<List<XFile>> convertAssetsToXFiles(List<Asset> assets) async {
    List<XFile> xFiles = <XFile>[];

    for (var asset in assets) {
      ByteData byteData = await asset.getByteData();
      Uint8List uint8List = byteData.buffer.asUint8List();
      // 파일 이름 설정 (임의 또는 고유한 이름)
      String fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      // XFile로 변환
      XFile xFile = XFile.fromData(uint8List, name: fileName);
      xFiles.add(xFile);
    }
    return xFiles;
  }
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
      );
      List<XFile> xFileList = await convertAssetsToXFiles(resultList);
      images = xFileList;
    } on Exception catch (e) {
      print('Error: $e');
    }
  }
  Future<XFile?> _compressAndGetFile(File file, String targetPath) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      minWidth: 600,
      minHeight: 600,
      quality: 50,
    );
    return result;
  }



  Future<void> onSubmit(File file) async {
    print('ExpertUploadImageStateNotifier_onSubmit()');

    String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
    final String baseUrl = "$SERVER_BASE_URL/users/experts/$expertId/images";
    // image path
    final targetFileNamePath = baseUrl.toString() + "/" + _timestamp() + ".jpg";
    final imgFile = await _compressAndGetFile(file, targetFileNamePath);
    final List<XFile> imagesXfile = imgFile as List<XFile>;
    List<MultipartFile> multipartFiles = [];

    state = ServerStatusLoading();
    try {
      //압축한 이미지 경로와 파일
      final compFilePath = imgFile!.path!;
      print('압축한 이미지 경로와 파일: $compFilePath');


      if (imgFile != null) {



        // 이미지 서버 업로드 요청 보냄
        final res = await repository.ExpertsUploadImage(id: expertId, images: imagesXfile);
        print('res상태 : $res');

        // 업로드 성공 여부 확인
        if (!res.success) {
          state = ServerStatusError(message: '서버 에러');
          print('Image Upload Failed');
        }
        print('Image Upload Succeeded');
        // 사용자 프로필 이미지 업데이트
        ref.read(ExpertUploadImageNotifierProvider.notifier);
        print('전문가 업로드 이미지 프로바이터 노티!!!!업데이트 상태 : ${ExpertUploadImageNotifierProvider.notifier}');
        state = ServerStatusSuccess();
      }
    } catch (error) {
      print(error);
      state = ServerStatusError(message: '서버 에러');
    }
  }

}


