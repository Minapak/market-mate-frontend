
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/constants/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/member/providers/member_edit_image_provider.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';
import 'package:sip_app/modules/member/repositories/member_repository.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class MemberImageView extends ConsumerWidget {
  final String? currentImage;

  MemberImageView({this.currentImage});

  Future<void> _pickImage(WidgetRef ref) async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
    imageQuality: 30);
    if (pickedFile != null) {
      if (pickedFile.mimeType != null ) {
        print("pickImageSuccess1.");
        print("pickImageSuccess2."'$pickedFile');
      } else {
        print('선택한 파일이 이미지 유형이 아닙니다3.');
      }
    }

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      aspectRatioPresets:
      [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop',
            cropGridColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(title: 'Crop')
      ],
    );

    if (croppedFile != null) {
      ref
          .read(memberEditImageViewProvider.notifier)
          .state = croppedFile;
      ref.read(memberEditImageNotifierProvider.notifier).onSubmit();
    } else {
      print('Image cropping failed.');
    }
  }
  // 데이터 불러오기
  Future<void> _loadData() async {
    final SharedPreferences UserUUID = await SharedPreferences.getInstance();
    try {
      String? UserID = UserUUID.getString('userUUID');
      print('유저아이디 스트링 화 : $UserID');
    }catch(e){}
  }
  Future<void> _uploadProfileImage(File imageFile) async {
    final dio = Dio();
    print('loadData : $_loadData()');
    try {
      // 이미지 압축
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        imageFile.path,
        imageFile.path,
        quality: 10, // 이미지 품질을 조절하세요.
      );


      final resp = await dio.put('$SERVER_BASE_URL/members/$memberUUIDProvider/image');
      final compressedFilePath = compressedFile?.path;

      if (resp.statusCode == 200) {
        var targetName = DateTime.now().millisecondsSinceEpoch;
        final formData = FormData.fromMap({
          'file': await MultipartFile.fromFile(
            compressedFilePath!,
            filename: "$targetName.jpg",
          ),
        });

        final response = await dio.post(resp.data as String, data: formData);

        if (response.statusCode == 200) {
          print('이미지 업로드 성공');
          print(response.data);
        } else {
          print('이미지 업로드 실패: ${response.statusCode}');
        }
      } else {
        print('이미지 업로드 실패: ${resp.statusCode}');
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }
    Widget build(BuildContext context, WidgetRef ref) {
      return GestureDetector(
        onTap: () {
          _pickImage(ref);
        },
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                _pickImage(ref);
                _uploadProfileImage;
                print('업로드 프로필 이미지 : $_uploadProfileImage');
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: IMAGE_UPLOAD_BUTTON_COLOR,
                  image: currentImage != null ? DecorationImage(
                    image: NetworkImage(currentImage!),
                    fit: BoxFit.cover,
                  ) : null,
                ),
                padding: EdgeInsets.all(28),
                child:
                currentImage == null ? Center(
                  child: SizedBox(
                      height: 44,
                      width: 44,
                      child: SvgPicture.asset(
                          'assets/icons/icon_user_default.svg',
                          fit: BoxFit.cover)
                  ),
                ) : SizedBox.shrink(),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(2),
                  child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: NAVIGATION_TEXT_COLOR,
                      ),
                      child: Center(
                        child: SizedBox(
                            width: 16,
                            height: 16,
                            child: SvgPicture.asset(
                                'assets/icons/icon_image_upload.svg')),
                      )),
                ))
          ],
        ),
      );
    }
  }
