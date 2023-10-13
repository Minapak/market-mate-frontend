

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/path.dart';

import '../../common/models/server_status_model.dart';
import '../../common/widgets/error_dialog_widget.dart';
import '../../common/widgets/loading_overlay.dart';
import '../providers/market_expert_handler.dart';

class MarketWholesaleHandler extends ConsumerWidget {
  MarketWholesaleHandler();

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final data = ref.watch(ShowMarketExpertProvider);

    final isLoading = data is ServerStatusLoading;
    final isError = data is ServerStatusError;
    final isSuccess = data is ServerStatusSuccess;


    if (isSuccess) {
      Future.microtask(() => context.go(PATH_EXPERTS));
    }
    if (isError) {
      Future.microtask(() =>
          ErrorDialog.showError(context, title: 'Error', message: '죄송합니다\n잠시후 다시 시도해주세요.'));
    }

    return LoadingOverlay(isLoading: isLoading, child: SizedBox.shrink());
  }
}