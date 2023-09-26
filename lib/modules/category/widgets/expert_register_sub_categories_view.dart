
import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/category/models/main_category_model.dart';

List<MainCategoryModel> categories = [
  MainCategoryModel(id: 1, path: 'https://via.placeholder.com/150', name: '돼지'),
];

class ExpertSubCategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(children: [
        ExpertSubCategoryItem(),
        ExpertSubCategoryItem(),
        ExpertSubCategoryItem(),
        ExpertSubCategoryItem(),
        ExpertSubCategoryItem(),
        ExpertSubCategoryItem(),
        ExpertSubCategoryItem(),
        ExpertSubCategoryItem(),
      ]),
    );
  }
}

class ExpertSubCategoryItem extends StatefulWidget {
  @override
  ExpertSubCategoryItemState createState() => ExpertSubCategoryItemState();
}

class ExpertSubCategoryItemState extends State<ExpertSubCategoryItem> {
  // final CategoryModel category;
  bool isSelected = false;
  // const ExpertSubCategoryItem({required this.category, Key? key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          decoration: BoxDecoration(
              border: Border(
                  bottom:
                      BorderSide(color: INPUT_BORDER_GRAY_COLOR, width: 1))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 24,
                height: 24,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            isSelected ? BUTTON_PRIMARY_COLOR : GRAY_COLOR_FONT,
                        width: 2),
                    borderRadius: BorderRadius.circular(50)),
                child: Container(
                  decoration: BoxDecoration(
                      color: isSelected
                          ? BUTTON_PRIMARY_COLOR
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              SizedBox(width: 40),
              Text(
                'asdasd',
                style: TextStyle(
                    color: BLACK_COLOR_FONT,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              )
            ],
          )),
    );
  }
}
