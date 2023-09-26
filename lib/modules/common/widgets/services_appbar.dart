import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';

List<MainCategoryModel> categories = [
  MainCategoryModel(id: 1, path: 'https://via.placeholder.com/150', name: '돼지'),
];

class ServicesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ServicesAppBar({required this.title, Key? key}) : super();

  @override
  Size get preferredSize => Size.fromHeight(155);

  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          // mainAxisSize: MainAxisSize.min,
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
            CategoryTabWrapper(),
            SizedBox(height: 20),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                      children: categories.map((category) {
                    return CategoryNavigateItem(category: category);
                  }).toList()),
                ))
          ],
        ));
  }
}

class CategoryTabWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: CategoryTab(
              label: "FAQ",
              isSelected: true,
            )),
        Expanded(
            flex: 1,
            child: CategoryTab(
              label: "Q&A",
              isSelected: false,
            ))
      ],
    );
  }
}

class CategoryTab extends StatelessWidget {
  final bool isSelected;
  final String label;

  const CategoryTab({required this.isSelected, required this.label, Key? key})
      : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
            height: 43,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isSelected
                      ? NAVIGATION_TEXT_COLOR
                      : BUTTON_GRAY_BORDER_COLOR,
                  width: 2.0,
                ),
              ),
            ),
            child: Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelected
                        ? NAVIGATION_TEXT_COLOR
                        : BOTTOM_NAVI_TEXT_COLOR,
                    fontSize: 14,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500))));
  }
}

class CategoryNavigateItem extends StatelessWidget {
  final MainCategoryModel category;
  const CategoryNavigateItem({required this.category, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: INPUT_BORDER_GRAY_COLOR, width: 1)),
        child: Text(category.name,
            style: TextStyle(
                color: COMMUNITY_CATEGORY_COLOR,
                fontSize: 14,
                fontWeight: FontWeight.w500)));
  }
}
