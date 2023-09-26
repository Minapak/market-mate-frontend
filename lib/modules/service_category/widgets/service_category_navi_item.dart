import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/service_category/models/service_category_model.dart';

class ServiceCategoryNavigateItem extends StatelessWidget {
  final ServiceCategoryModel category;
  final Function(int) onSelectServiceCategory;
  final bool isSelected;

  const ServiceCategoryNavigateItem({
    required this.category,
    required this.isSelected,
    required this.onSelectServiceCategory,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      child: OutlinedButton(
          onPressed: () {
            onSelectServiceCategory(category.id);
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isSelected ? BUTTON_PRIMARY_COLOR : INPUT_BORDER_GRAY_COLOR, // 선택 상태에 따른 색상 변경
              width: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // borderRadius 10px
            ),
          ),
          child: Text(category.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isSelected ? BUTTON_PRIMARY_COLOR : COMMUNITY_CATEGORY_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w500))),
    );
  }
}