import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/category/widgets/middle_category_hashtag_view.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';
import 'package:sip_app/modules/matching/models/matching_model.dart';

class ExpertMatchingsView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemBuilder: (BuildContext context, int index) {
          return ExpertMatchingItem();
        },
        itemCount: 2,
    );
  }
}

class ExpertMatchingItem extends StatelessWidget {

  ExpertMatchingItem();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push('/experts/detail');
        },
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: IntrinsicHeight(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                  image: NetworkImage('https://via.placeholder.com/150'),
                                  fit: BoxFit.cover)),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('박명수',
                                      style: TextStyle(
                                          color: FIXED_WIDGET_BACKGROUNG_COLOR,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  ExpertMatchingStatusItem(status: '상인 확인 필요')
                                ],
                              ),
                            )),
                            Text('2023.03.27',
                              style: TextStyle(
                                color: BOTTOM_NAVI_TEXT_COLOR,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                              ),
                            )
                      ]),
                )),
          ],
        ));
  }
}

class ExpertMatchingStatusItem extends StatelessWidget {
  final String status;

  ExpertMatchingStatusItem({required this.status});

  @override
  Widget build(BuildContext context) {
    return  Container(
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
              child: Text(status,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: COMMUNITY_CATEGORY_COLOR,
                      fontSize: 12,
                      fontWeight: FontWeight.w700)))),
    );
  }
}