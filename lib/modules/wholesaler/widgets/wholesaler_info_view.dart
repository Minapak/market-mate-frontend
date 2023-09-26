import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';

class wholesalerInfoView extends StatelessWidget {
 // final String career;
  final String content;

  const wholesalerInfoView({
  //  required this.career,
    required this.content,
    Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '경력',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: SECTION_FONT_COLOR,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                width: 1,
                height: 12,
                color: INPUT_BORDER_GRAY_COLOR,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              ),
              // Text(
              //   career,
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //       color: COMMUNITY_CATEGORY_COLOR,
              //       fontSize: 14,
              //       fontWeight: FontWeight.w500),
              // ),
            ]),
      ),
      Container(
        width: double.infinity,
        height: 1,
        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
        color: INPUT_BACKGROUND_GRAY_COLOR,
      ),
      Container(
          alignment: Alignment.topLeft,
          child: Text('도/소매 상인 소개',
              style: TextStyle(
                  color: SECTION_FONT_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w700))),
      Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(content,
              style: TextStyle(
                  color: COMMUNITY_CATEGORY_COLOR,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)))
    ]));
  }
}
