import 'package:flutter/material.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/route_model.dart';
import 'package:sip_app/modules/service_center/widgets/service_center_item.dart';

List<RouteModel> routes = [
  RouteModel(id: 1, name: '자주 묻는 질문', link: PATH_SERVICES_FAQ),
  RouteModel(id: 1, name: '문의하기', link: PATH_SERVICES_QNA),
  RouteModel(id: 1, name: '나의 문의 보기', link: PATH_SERVICES_QNA),
];

class ServiceCenterView extends StatelessWidget {
  const ServiceCenterView();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
          children: List.generate(
              routes.length,
                  (i) => ServiceCenterItem(
                route: routes[i],
                isLastIndex: i + 1 == routes.length,
              ))),
    );
  }
}