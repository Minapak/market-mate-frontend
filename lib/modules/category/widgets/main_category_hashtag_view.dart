
import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';

class CategoryHashtagView extends StatelessWidget {
  final String name;

  const CategoryHashtagView({required this.name, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: CATEGORY_BACKGROUND_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        padding: EdgeInsets.fromLTRB(6, 2, 6, 3),
        margin: EdgeInsets.fromLTRB(0, 0, 6, 6),
        child: Text('${name}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: NAVIGATION_TEXT_COLOR,
                fontSize: 12,
                fontWeight: FontWeight.w500)));
  }
}
