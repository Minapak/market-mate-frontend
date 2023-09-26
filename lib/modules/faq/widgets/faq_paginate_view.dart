
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/faq/models/faq_model.dart';
import 'package:sip_app/modules/faq/providers/faq_list_provider.dart';
import 'package:sip_app/modules/faq/widgets/faq_item.dart';
import 'package:sip_app/modules/service_category/providers/service_category_view_provider.dart';

// FAQ 목록 가지고 와서 페이지네이션 UI
class FaqPaginateView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryId = ref.watch(ServiceCategorySelectProvider);
    final data = ref.watch(FaqListStateNotifierProvider(categoryId));

    if (data is PaginationLoading) {
      return Container();
    }

    if (data is PaginationError) {
      return Text('에러');
    }

    final pData = data as Pagination;

    return ListView.builder(
      itemCount: pData.content.length,
      itemBuilder: (context, index) {
        return FaqItem(faq: pData.content[index]);
      }
    );
  }
}