import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/category/widgets/expert_register_sub_categories_view.dart';

class ExpertSubCategoriesScreen extends StatelessWidget {
  const ExpertSubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        appBar: BackAppBar(title: '카테고리 선택'),
        child: ExpertSubCategoriesView(),
        backgroundColor: Colors.white);
  }
}
