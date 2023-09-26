import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/faq/widgets/faq_paginate_view.dart';
import 'package:sip_app/modules/service_category/widgets/service_categories_view.dart';

// FAQ 목록 및 서비스 카테고리 까지 보여주는 UI
class FaqListView extends ConsumerWidget {
  FaqListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ServiceCategoriesView(serviceType: 'FAQ'),
        Expanded(child:  FaqPaginateView()),
        // FaqPaginateView()
      ],
    );
  }
}