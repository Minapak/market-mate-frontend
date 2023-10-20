import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// 사용자 정의 색상과 경로를 가져오는 데 필요한 import문
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/constants/path.dart';
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
import '../../../config/colors.dart';
import '../../../config/font_family.dart';
import '../../../config/size_config.dart';
import '../../category/models/categories_response_model.dart';
import '../../category/models/main_category_model.dart';
import '../../category/providers/select_category_view_provider.dart';
import '../../category/repositories/category_repository.dart';

// 마이페이지에서 전문가 등록을 위한 화면 위젯입니다.
class MypageRegisterExpertView extends StatelessWidget {
  int selectedCategoryIndex = 0;
  String selectedCategory = '';
  final List<String> CategoryList = [
    '돼지',
    '닭',
    '소',
    '해산물',
    '야채',
    '과일',
    '분식',
    '반찬',
    '옷',
    '액세서리',
    '한약재',
    '기타',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegisterItem(
              label: '전문가 이름',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RegisterNameInput(),
                ],
              ),
            ),
            RegisterItem(
              label: '전문가 소개',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RegisterInput(),
                ],
              ),
            ),
            RegisterItem(
              label: '카테고리',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RegisterCategory(),
                ],
              ),
            ),
            RegisterItem(
              label: '이미지 업로드',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageUploadView(),
                ],
              ),
            ),
            // RegisterItem(
            //   label: '이미지',
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       ExpertImageUploadView(),
            //     ],
            //   ),
            // ),
            RegisterItem(child: RegisterCheckTextarea(), label: '경력'),
           // RegisterItem(child: RegisterTextarea(), label: '소개글'),
          ],
        ),
      ),
    );
  }

}

// 전문가 이미지 업로드 위젯
class ExpertImageUploadView extends StatefulWidget {
  @override
  ExpertImageUploadViewState createState() => ExpertImageUploadViewState();
}

class ExpertImageUploadViewState extends State<ExpertImageUploadView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 이미지 업로드 모달 아래에서 열기
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return ImageUploadModalBottomsheet();
          },
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: BUTTON_GRAY_BORDER_COLOR,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 28,
                height: 28,
                child: SvgPicture.asset('assets/icons/icon_image_plus.svg'),
              ),
              SizedBox(height: 10),
              Text(
                '이미지 추가',
                style: TextStyle(
                  color: COMMUNITY_CATEGORY_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 등록 항목을 래핑하는 컨테이너 위젯
class RegisterItem extends StatelessWidget {
  final Widget child;
  final String label;

  const RegisterItem({required this.child, required this.label, Key? key})
      : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: BLACK_COLOR_FONT,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          child,
          SizedBox(height: 28),
        ],
      ),
    );
  }
}

// 텍스트 입력 멀티라인 위젯
class RegisterNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: INPUT_BORDER_GRAY_COLOR),
      ),
      child: TextField(
        maxLines: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '전문가님의 별명 혹은 이름을 적어주세요.',
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(
            color: Colors.grey, // 원하는 색상으로 변경
          ),
        ),
      ),
    );
  }
}
// 텍스트 입력 멀티라인 위젯
class RegisterInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 117,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: INPUT_BORDER_GRAY_COLOR),
      ),
      child: TextField(
        maxLines: 10,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '전문가님을 설명할 수 있는 간단한 문구를 적어주세요.',
          contentPadding: EdgeInsets.all(10),
          hintStyle: TextStyle(
            color: Colors.grey, // 원하는 색상으로 변경
          ),
        ),
      ),
    );
  }
}

// 텍스트 입력 멀티라인 위젯
class RegisterTextarea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 117,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: INPUT_BORDER_GRAY_COLOR),
      ),
      child: TextField(
        maxLines: 10,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '내용을 입력해주세요.',
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}

class RegisterCheckTextarea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 117,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: INPUT_BORDER_GRAY_COLOR),
      ),
      child: TextField(
        maxLines: 10,
        enabled: false, // 입력 비활성화
        decoration: InputDecoration(
          hintText: '경력은 사업자 인증 후 등록이 가능합니다. (경력 인증은 010-8306-4017로 연락주시면 됩니다.)',
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}

class RegisterDropdown extends StatefulWidget {
  @override
  RegisterDropdownState createState() => RegisterDropdownState();
}

class RegisterDropdownState extends State<RegisterDropdown> {
  // 현재 선택한 값
  String? dropdownValue = 'Option 1';

  // 가능한 선택 옵션
  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];

  // 메서드를 통해 알림 팝업을 열기
  void _showOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('옵션 선택'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((String option) {
              return ListTile(
                title: Text(option),
                onTap: () {
                  setState(() {
                    dropdownValue = option;
                  });
                  Navigator.of(context).pop(); // 팝업 닫기
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showOptionsDialog, // 클릭 시 알림 팝업 열기
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: 48.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: INPUT_BORDER_GRAY_COLOR),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(dropdownValue ?? 'Option 1'),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}

// 카테고리 등록 위젯
class RegisterCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            context.push(PATH_USER_EXPERT_MAIN_CATEGORIES);
          },
          child: Container(
            decoration: BoxDecoration(
              color: INPUT_BACKGROUND_GRAY_COLOR,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        CategoriesWrapper(),
      ],
    );
  }
}


class ImageUploadView extends ConsumerWidget {
  final String? currentImage;

  ImageUploadView({this.currentImage});

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


    ///
    ///
    ///여기 memberEditImageViewProvider.notifier 아닌
    ///expert_upload_image_provider 만들 것!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    ///
    ///
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
  Future<void> _uploadExpertImage(File imageFile) async {
    final dio = Dio();
    print('loadData : $_loadData()');
    try {
      // 이미지 압축
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        imageFile.path,
        imageFile.path,
        quality: 10, // 이미지 품질을 조절하세요.
      );


      final resp = await dio.put('$SERVER_BASE_URL/admin/users/$memberUUIDProvider/expert');
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
              _uploadExpertImage;
              print('업로드 전문가 이미지 : $_uploadExpertImage;');
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
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
                        'assets/icons/icon_plus_white.svg',
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

// 이미지 업로드 모달 바텀 시트 위젯
class ImageUploadModalBottomsheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ClipRRect(
            child: GridView.count(
              padding: EdgeInsets.only(bottom: 70.0),
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              children: List.generate(20, (index) => ImageItem()),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  color: Colors.white.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 50, height: 50),
                      Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: BUTTON_PRIMARY_COLOR,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/icon_plus_white.svg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          child: Text(
                            '삭제',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 이미지 아이템 위젯
class ImageItem extends StatefulWidget {
  @override
  ImageItemState createState() => ImageItemState();
}

class ImageItemState extends State<ImageItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://via.placeholder.com/150'),
              ),
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: isSelected ? BUTTON_PRIMARY_COLOR : Colors.transparent,
                border: Border.all(
                  color: isSelected ? BUTTON_PRIMARY_COLOR : Colors.white,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// 카테고리 래핑 위젯
class CategoriesWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 6,
      spacing: 6,
      children: [
        AddCategoryItem(text: '돼지'),
        AddCategoryItem(text: '닭'),
        AddCategoryItem(text: '소'),
        AddCategoryItem(text: '해산물'),
        AddCategoryItem(text: '야채'),
        AddCategoryItem(text: '과일'),
        AddCategoryItem(text: '분식'),
        AddCategoryItem(text: '반찬'),
        AddCategoryItem(text: '옷'),
        AddCategoryItem(text: '액세서리'),
        AddCategoryItem(text: '한약재'),
        AddCategoryItem(text: '기타'),
      ],
    );
  }
}


class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  final List<String> widgetList = [
    '돼지', '닭', '소', '해산물', '야채', '과일', '분식', '반찬', '옷', '액세서리', '한약재', '기타',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widgetList.length,
      itemBuilder: (context, index) {
        final text = widgetList[index];
        return AddCategoryItem(text: text);
      },
    );
  }
}

class AddCategoryItem extends StatefulWidget {
  final String text;

  AddCategoryItem({required this.text});

  @override
  _AddCategoryItemState createState() => _AddCategoryItemState();
}

class _AddCategoryItemState extends State<AddCategoryItem> {
  bool isSelected = false;
  late final MainCategoryModel _mainCategoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          // 이미 선택된 경우 선택 해제
          setState(() {
            isSelected = false;
          });
        } else {
          // 선택되지 않은 경우
          int selectedItemCount = 0;

          // 최대 선택 가능한 아이템 수 (예: 2개)
          int maxSelectionCount = 2;

          if (selectedItemCount < maxSelectionCount) {
            // 선택 가능한 경우 선택
            setState(() {
              isSelected = true;
            });
          } else {
            // 선택 수 초과 시 알림 표시
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('알림'),
                  content: Text('최대 ${maxSelectionCount}개까지 선택할 수 있습니다.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('확인'),
                    ),
                  ],
                );
              },
            );
          }
        }
      },
      child: Container(
        width: 105,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? BUTTON_PRIMARY_COLOR : Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              widget.text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black.withOpacity(0.5),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 15),
            SizedBox(
              width: 14,
              height: 14,
            ),
          ],
        ),
      ),
    );
  }
}






