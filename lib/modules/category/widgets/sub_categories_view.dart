import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/category/models/categories_response_model.dart';
import 'package:sip_app/modules/category/models/middle_category_model.dart';
import 'package:sip_app/modules/category/providers/select_category_view_provider.dart';

class SubCategoriesView extends ConsumerWidget {
  final String type;

  SubCategoriesView({required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectCategoryPair = ref.watch(selectCategoryPairProvider(type));
    final selectedCategoryId = selectCategoryPair.mainCategoryId;
    final middleCategoryIds = selectCategoryPair.middleCategoryIds;
    final selectedMiddleCategoryId = middleCategoryIds[selectedCategoryId];
    final middleCategoriesData =
        ref.watch(middleCategoryListProvider(selectedCategoryId));

    void onSelectSubCategory(int id, bool isSelected) {
      ref
          .read(selectCategoryPairProvider(type).notifier)
          .selectMiddleCategory(id, isSelected);
    }

    if (middleCategoriesData is MiddleCategoriesResposeLoading) {
      return SizedBox(height: 1.0);
    }

    if (middleCategoriesData is MiddleCategoriesResponseError) {
      return SizedBox(height: 1.0);
    }

    final pCategories = middleCategoriesData as MiddleCategoriesResponseModel;

    if (pCategories.middleCategories.length == 0) {
      return Text('djqtasd');
    }

    print('selectedMiddleCategoryId, $selectedMiddleCategoryId');
    return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Wrap(
            children: List.generate(
                pCategories.middleCategories.length,
                (i) => SubCategoryItem(
                      category: pCategories.middleCategories[i],
                      is3n: (i + 1) % 3 == 0,
                      onSelectItem: onSelectSubCategory,
                      isSelected: pCategories.middleCategories[i].id ==
                          selectedMiddleCategoryId,
                    ))));
  }
}

class SubCategoryItem extends StatelessWidget {
  final MiddleCategoryModel category;
  final bool is3n;
  final bool isSelected;
  final Function onSelectItem;

  const SubCategoryItem(
      {required this.category,
      required this.is3n,
      required this.onSelectItem,
      this.isSelected = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: is3n ? EdgeInsets.all(0) : EdgeInsets.only(right: 10),
      width: (MediaQuery.of(context).size.width - 60) / 3,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor:
                isSelected ? NAVIGATION_TEXT_COLOR : Colors.transparent,
            side: BorderSide(
                color: isSelected
                    ? NAVIGATION_TEXT_COLOR
                    : BUTTON_GRAY_BORDER_COLOR,
                width: 1),
          ),
          onPressed: () {
            onSelectItem(category.id, isSelected);
          },
          child: Text(category.name,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: isSelected ? Colors.white : COMMUNITY_CATEGORY_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w500))),
    );
  }
}
