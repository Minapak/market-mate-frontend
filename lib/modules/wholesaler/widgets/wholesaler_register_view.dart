import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/constants/path.dart';

class WholesalerRegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        RegisterItem(
          label: '이미지',
          child: ExpertImageUploadView(),
        ),
        RegisterItem(
          label: '제목',
          child: RegisterInput(),
        ),
        RegisterItem(
          label: '카테고리',
          child: RegisterCategory(),
        ),
        RegisterItem(child: RegisterDropdown(), label: '경력'),
        RegisterItem(child: RegisterTextarea(), label: '약력'),
        RegisterItem(child: RegisterTextarea(), label: '소개글'),
      ]),
    );
  }
}

class ExpertImageUploadView extends StatefulWidget {
  @override
  ExpertImageUploadViewState createState() => ExpertImageUploadViewState();
}

class ExpertImageUploadViewState extends State<ExpertImageUploadView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return ImageUploadModalBottomsheet();
            });
      },
      child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: BUTTON_GRAY_BORDER_COLOR,
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  width: 28,
                  height: 28,
                  child: SvgPicture.asset('assets/icons/icon_image_plus.svg')),
              SizedBox(height: 10),
              Text('이미지 추가',
                  style: TextStyle(
                      color: COMMUNITY_CATEGORY_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.w500))
            ]),
          )),
    );
  }
}

class RegisterItem extends StatelessWidget {
  final Widget child;
  final String label;

  const RegisterItem({required this.child, required this.label, Key? key})
      : super();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: TextStyle(
              color: BLACK_COLOR_FONT,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      SizedBox(height: 10),
      child,
      SizedBox(height: 28),
    ]));
  }
}

class RegisterInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: INPUT_BORDER_GRAY_COLOR),
      ),
      child: TextField(
        maxLines: 5,
        minLines: 3,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '제목을 입력해주세요.',
          contentPadding: EdgeInsets.all(10), // Padding inside the TextField
        ),
      ),
    );
  }
}

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
          hintText: '제목을 입력해주세요.',
          contentPadding: EdgeInsets.all(10), // Padding inside the TextField
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
  String? dropdownValue = 'Option 1';

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 48.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: INPUT_BORDER_GRAY_COLOR),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          isExpanded: true,
          iconSize: 24,
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>['Option 1', 'Option 2', 'Option 3']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

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
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                  color: INPUT_BACKGROUND_GRAY_COLOR,
                  borderRadius: BorderRadius.circular(100)),
              child: Text('+ 추가',
                  style: TextStyle(
                      color: COMMUNITY_CATEGORY_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.w500))),
        ),
        SizedBox(
          height: 10,
        ),
        CategoriesWrapper(),
      ],
    );
  }
}

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
                  children: List.generate(20, (index) => ImageItem())),
            )),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              child: SvgPicture.asset(
                                  'assets/icons/icon_plus_white.svg',
                                  fit: BoxFit.cover)),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            child: GestureDetector(
                                child: Text('삭제',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500))),
                          )
                        ],
                      ))),
            )))
      ],
    );
  }
}

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
                      image: NetworkImage('https://via.placeholder.com/150'))),
            ),
            Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color:
                        isSelected ? BUTTON_PRIMARY_COLOR : Colors.transparent,
                    border: Border.all(
                        color: isSelected ? BUTTON_PRIMARY_COLOR : Colors.white,
                        width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ))
          ],
        ));
  }
}

class CategoriesWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 6,
      spacing: 6,
      children: [
        AddCategoryItem(),
        AddCategoryItem(),
        AddCategoryItem(),
        AddCategoryItem(),
        AddCategoryItem(),
        AddCategoryItem(),
        AddCategoryItem(),
        AddCategoryItem(),
        AddCategoryItem(),
        AddCategoryItem(),
        AddCategoryItem(),
        AddCategoryItem(),
      ],
    );
  }
}

class AddCategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
          child: Container(
        decoration: BoxDecoration(
            color: BUTTON_PRIMARY_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('닭다리살', style: TextStyle(color: Colors.white, fontSize: 14)),
            SizedBox(width: 10),
            SizedBox(
              width: 14,
              height: 14,
              child: SvgPicture.asset('assets/icons/icon_plus_white.svg'),
            )
          ],
        ),
      )),
    );
  }
}
