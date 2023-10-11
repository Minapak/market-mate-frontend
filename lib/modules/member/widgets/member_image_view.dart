
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/member/providers/member_edit_image_provider.dart';

class MemberImageView extends ConsumerWidget {
  final String? currentImage;

  MemberImageView({this.currentImage});

  Future<void> _pickImage(WidgetRef ref) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
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
      ref.read(memberEditImageViewProvider.notifier).state = croppedFile;
      ref.read(memberEditImageNotifierProvider.notifier).onSubmit();
    } else {
      print('Image cropping failed.');
    }
  }
  Future<void> _uploadProfileImage() async {
    final imagePicker = ImagePicker();

    // 갤러리에서 이미지를 선택합니다.
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // 이미지가 선택되었을 경우, 해당 이미지를 서버로 업로드하거나
      // 필요한 처리를 수행하세요.
      final imageFile = File(pickedFile.path);

      // 여기에서 이미지를 업로드하거나 다른 작업을 수행할 수 있습니다.
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
          onTap:() {
            _pickImage(ref);
          },
         child:  Container(
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
                  child: SvgPicture.asset('assets/icons/icon_user_default.svg',
                      fit: BoxFit.cover)
                ),
              ):SizedBox.shrink(),
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
