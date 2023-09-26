
import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/qna/models/qna_model.dart';

class QnaItem extends StatelessWidget {
  final QnaModel qna;
  QnaItem({required this.qna});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 0,
                  child: Text('Q',
                      style: TextStyle(
                          color: PRIMARY_DARK_BUTTON_COLOR,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('글 제목글 제목글 제목글 제목글 제목글 제목글 제목글 제목글 제목글 제목글 제목글 제목글 제목글',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: FIXED_WIDGET_BACKGROUNG_COLOR,
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 27),
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.only(right: 18),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                  color: PRIMARY_DARK_BUTTON_COLOR,
                ),
              ),
              child: Text('답변 중',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: PRIMARY_DARK_BUTTON_COLOR,
                  fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 1,
            color: INPUT_BACKGROUND_GRAY_COLOR,
          )
        ],
      ));
  }
}