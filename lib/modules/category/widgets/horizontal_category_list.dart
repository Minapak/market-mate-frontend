import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/category/models/categories_response_model.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';
import 'package:sip_app/modules/category/providers/select_category_view_provider.dart';

class HorizontalCategoryList extends ConsumerStatefulWidget {
  final String type;

  HorizontalCategoryList({required this.type});

  @override
  HorizontalCategoryListState createState() => HorizontalCategoryListState();
}

class HorizontalCategoryListState extends ConsumerState<HorizontalCategoryList> {
  late Future categoriesFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = ref.read(mainCategoryListProvider.notifier).initialize();
  }

  void selectMainCategory(int id) {
    ref.read(selectCategoryPairProvider(widget.type).notifier).selectedMainCategory(id);
  }

  @override
  Widget build(BuildContext context) {
    final selectedMainCategoryData = ref.watch(selectCategoryPairProvider(widget.type));

    return FutureBuilder(
        future: categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 43,
              decoration: BoxDecoration(color: Colors.white),
            );
          }

          if (snapshot.hasError) {
            return Text('ERROR');
          }

          if (!snapshot.hasData) {
            return Text('Data is still loading');
          }

          final pData = snapshot.data as MainCategoriesResponseModel;

          return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                    children: pData.mainCategories.map((category) {
                      return CategoryNavigateItem(
                          isSelected: selectedMainCategoryData.mainCategoryId ==
                              category.id,
                          category: category,
                          selectMainCategory: selectMainCategory);
                    }).toList()),
              ));
        });
  }
}

class CategoryNavigateItem extends StatelessWidget {
  final MainCategoryModel category;
  final Function(int) selectMainCategory;
  final bool isSelected;

  const CategoryNavigateItem(
      {required this.category,
        required this.selectMainCategory,
        required this.isSelected,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      height: 43,
      child: TextButton(
          onPressed: () {
            selectMainCategory(category.id);
          },
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
                  color: isSelected ? BLACK_COLOR_FONT : BOTTOM_NAVI_TEXT_COLOR,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500))),
    );
  }
}

