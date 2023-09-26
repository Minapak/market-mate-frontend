
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/common/widgets/error_dialog_widget.dart';
import 'package:sip_app/modules/common/widgets/loading_overlay.dart';
import 'package:sip_app/modules/member/providers/member_edit_image_provider.dart';
import 'package:sip_app/modules/review/providers/delete_review_provider.dart';

class MypageReviewsHandler extends ConsumerWidget {
  MypageReviewsHandler();

  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(deleteReviewNotifierProvider);

    final isLoading = data is ServerStatusLoading;
    final isError = data is ServerStatusError;
    final isSuccess = data is ServerStatusSuccess;

    if (isSuccess) {
      Future.microtask(() => print('success'));
    }

    if(isError) {
      Future.microtask(() =>
          ErrorDialog.showError(context, title: '리뷰 삭제', message: '리뷰 삭제에 실패하였습니다.\n다음에 다시 시도해주세요.'));
    }

    return LoadingOverlay(isLoading: isLoading, child: SizedBox.shrink());
  }
}