import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';

class CategoriesView extends StatelessWidget {
  final List<MainCategoryModel> categories;

  CategoriesView({required this.categories});

  @override
  Widget build(BuildContext context) {
    final double containerWidth =
        (categories.length / 2).ceil().toDouble() * 110;
    print(
      '$containerWidth containerWidth',
    );
    return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        scrollDirection: Axis.horizontal,
        child: Container(
          width: containerWidth,
          child: Wrap(
              children: categories.map((category) {
            return CategoryItem(category: category);
          }).toList()),
        ));
  }
}

class CategoryItem extends StatelessWidget {
  final MainCategoryModel category;

  const CategoryItem({required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.fromLTRB(0, 0, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CachedNetworkImage(
                imageUrl: category.path ?? '',
                imageBuilder: (context, imageProvider) => Container(
                  margin: EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit:
                          BoxFit.cover, // 이미지를 적절히 크기에 맞추려면 BoxFit.cover 사용합니다.
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(color: GRAY_COLOR_FONT)),
                errorWidget: (context, url, error) => Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(color: GRAY_COLOR_FONT)),
              ),
            ),
            Text(
              category.name,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: SECTION_FONT_COLOR),
            )
          ],
        ));
  }
}
