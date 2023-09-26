
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/qna/providers/qna_list_provider.dart';
import 'package:sip_app/modules/qna/widgets/qna_item.dart';

class QnaListView extends ConsumerWidget {
  QnaListView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(QnaListStateNotifierProvider);

    if (data is PaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is PaginationError) {
      return Container();
    }

    final pData = data as Pagination;

    return ListView.builder(
        itemCount: pData.content.length,
        itemBuilder: (context, index) {
          return QnaItem(qna: pData.content[index]);
        }
    );
  }
}