import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';

List<MainCategoryModel> categories = [
  MainCategoryModel(id: 1, path: 'https://via.placeholder.com/150', name: '돼지'),
];

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CategoryAppBar({required this.title, Key? key}) : super();

  @override
  Size get preferredSize => Size.fromHeight(97.0);

  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          children: [
            Container(
              height: 54,
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Container(
                          width: 18,
                          height: 18,
                          child:
                              SvgPicture.asset('assets/icons/icon_back.svg'))),
                  Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: SECTION_FONT_COLOR,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(width: 18, height: 18),
                ],
              ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                      children: categories.map((category) {
                    return CategoryNavigateItem(category: category);
                  }).toList()),
                ))
          ],
        ));
  }
}

class CategoryNavigateItem extends StatelessWidget {
  final MainCategoryModel category;
  const CategoryNavigateItem({required this.category, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      height: 43,
      child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(15, 23),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft)
              .copyWith(
                  overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }
            return null;
          })),
          child: Text(category.name,
              style: TextStyle(
                  color: BOTTOM_NAVI_TEXT_COLOR,
                  fontSize: 16,
                  fontWeight: FontWeight.w500))),
    );
  }
}
