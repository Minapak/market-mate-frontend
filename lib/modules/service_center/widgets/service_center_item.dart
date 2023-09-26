import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/common/models/route_model.dart';

class ServiceCenterItem extends StatelessWidget {
  final RouteModel route;
  final bool isLastIndex;

  ServiceCenterItem(
      {required this.route, required this.isLastIndex, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onTap() {
      print(route.link);
      context.push(route.link);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    color: isLastIndex ? Colors.white : INPUT_BACKGROUND_GRAY_COLOR,
                    width: 1,
                  ))),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                route.name,
                style: TextStyle(
                    color: SECTION_FONT_COLOR,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                width: 4,
                height: 8,
                child: SvgPicture.asset('assets/icons/icon_right_small.svg',
                    fit: BoxFit.cover),
              ),
            ],
          )),
    );
  }
}