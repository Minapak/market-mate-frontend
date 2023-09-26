import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';

List<MainCategoryModel> categories = [
  MainCategoryModel(id: 1, path: 'https://via.placeholder.com/150', name: '돼지'),
];

class ExpertCategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: categories
                .map((category) => ExpertCategoryItem(category: category))
                .toList()));
  }
}

class ExpertCategoryItem extends StatelessWidget {
  final MainCategoryModel category;

  const ExpertCategoryItem({required this.category, Key? key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(PATH_USER_EXPERT_SUB_CATEGORIES);
      },
      child: Container(
          decoration: BoxDecoration(
              color: INPUT_BORDER_GRAY_COLOR,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(category.path ?? ''))),
              ),
              SizedBox(height: 6),
              Text(category.name,
                  style: TextStyle(
                      color: SECTION_FONT_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.w500))
            ],
          )),
    );
  }
}
