import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/category/widgets/expert_register_categories_view.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';

class ExpertCategoriesScreen extends StatelessWidget {
  const ExpertCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        appBar: BackAppBar(title: '카테고리 분류'),
        child: ExpertCategoriesView(),
        isNeedListview: false,
        backgroundColor: Colors.white);
  }
}
