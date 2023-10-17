import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';
import 'package:sip_app/modules/category/widgets/middle_category_hashtag_view.dart';


class ExpertItem extends StatelessWidget {
  final ExpertModel expert;

  const ExpertItem({required this.expert, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          final int id = expert.id;
          final String name = expert.name;
          context.push('/experts/detail/$id?name=$name');
        },
        child: Container(
            padding: EdgeInsets.all(16),
            // margin: EdgeInsets.only(bottom: 10),
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
                              image: NetworkImage(expert.thumbnail ?? ''),
                              fit: BoxFit.cover)),
                    ),
                    Expanded(
                        flex: 1,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${expert.name} 전문가',
                                  style: TextStyle(
                                      color: FIXED_WIDGET_BACKGROUNG_COLOR,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700)),
                              SizedBox(
                                height: 4,
                              ),
                              Text('${expert.marketName}',
                                  style: TextStyle(
                                      color: COMMUNITY_CATEGORY_COLOR,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 4,
                              ),
                              Text('${expert.content}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: GRAY_COLOR_FONT,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 2,
                              ),
                              Wrap(
                                children: expert.middleCategories!
                                    .map((item) =>
                                        HashtagItemView(name: item.name))
                                    .toList(),
                              )
                            ],
                          ),
                        ))
                  ]),
            )));
  }
}
