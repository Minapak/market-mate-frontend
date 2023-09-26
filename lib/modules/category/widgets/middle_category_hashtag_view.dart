import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';

class HashtagItemView extends StatelessWidget {
  final String name;

  const HashtagItemView({required this.name, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 6, 6, 0),
      child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                  minimumSize: Size(15, 23),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                  backgroundColor: BUTTON_GRAY_BORDER_COLOR)
              .copyWith(
                  overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }
            return null;
          })),
          child: Container(
              child: Text('#${name}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: COMMUNITY_CATEGORY_COLOR,
                      fontSize: 12,
                      fontWeight: FontWeight.w500)))),
    );
  }
}
