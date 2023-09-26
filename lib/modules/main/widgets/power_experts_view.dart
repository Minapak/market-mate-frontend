import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';

class PowerExpertsView extends StatelessWidget {
  final List<ExpertModel> experts;

  PowerExpertsView({required this.experts});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        scrollDirection: Axis.horizontal,
        child: Container(
          child: Row(
              children: experts.map((expert) {
            return PowerExpertsItem(expert: expert);
          }).toList()),
        ));
  }
}

class PowerExpertsItem extends StatelessWidget {
  final ExpertModel expert;

  const PowerExpertsItem({required this.expert, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        final int id = expert.id;
        final String name = expert.name;

        context.push('/experts/detail/$id?name=$name');
      },
      child: Container(
          width: 116,
          height: 178,
          margin: EdgeInsets.only(right: 8),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CachedNetworkImage(
                  imageUrl: expert.thumbnail ?? '',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        )),
                  ),
                  placeholder: (context, url) => Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: GRAY_COLOR_FONT),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: GRAY_COLOR_FONT),
                  ),
                ),
              ),
              Text(expert.name,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: FIXED_WIDGET_BACKGROUNG_COLOR)),
              Container(
                  padding: EdgeInsets.fromLTRB(8, 3, 8, 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: CATEGORY_BACKGROUND_COLOR,
                  ),
                  child: Text(
                    expert.mainCategories![0].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: BUTTON_PRIMARY_COLOR),
                  ))
            ],
          )),
    );
  }
}
