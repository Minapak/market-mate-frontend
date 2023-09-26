import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/service_category/providers/service_category_list_provider.dart';
import 'package:sip_app/modules/service_category/providers/service_category_view_provider.dart';
import 'package:sip_app/modules/service_category/widgets/service_category_navi_item.dart';

class ServiceCategoriesView extends ConsumerWidget {
  final String serviceType;
  ServiceCategoriesView({required this.serviceType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryId = ref.watch(ServiceCategorySelectProvider);
    final data = ref.watch(ServiceCategoryListNotifierProvider(serviceType));

    if (data is PaginationLoading) {
      return Container();
    }

    if (data is PaginationError) {
      return Container();
    }

    final pData = data as Pagination;

    void onSelectServiceCategory(int categoryId) {
      ref.read(ServiceCategorySelectProvider.notifier).state = categoryId;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        scrollDirection: Axis.horizontal,
        child: Container(
          child: Row(
              children: pData.content.map((category) {
                return ServiceCategoryNavigateItem(
                    isSelected: selectedCategoryId == category.id,
                    category: category,
                    onSelectServiceCategory: onSelectServiceCategory
                );
              }).toList()),
        ));
  }
}