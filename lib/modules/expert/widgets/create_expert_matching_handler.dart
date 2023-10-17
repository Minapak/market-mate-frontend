import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/auth/providers/signup_submit_provider.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/common/widgets/error_dialog_widget.dart';
import 'package:sip_app/modules/common/widgets/loading_overlay.dart';
import 'package:sip_app/modules/expert/providers/create_expert_matching_provider.dart';

class CreateExpertMatchingHandler extends ConsumerWidget {
  CreateExpertMatchingHandler();

  @override
  Widget build(BuildContext context, WidgetRef ref){
    var data;
    try{
      data = ref.watch(createExpertMatchingProvider);
    }catch(e){
      Future.microtask(() =>
          ErrorDialog.showError(context, title: 'Error', message: data.message ?? '죄송합니다\n잠시후 다시 시도해주세요.'));
    }

    final isLoading = data is ServerStatusLoading;
    final isError = data is ServerStatusError;
    final isSuccess = data is ServerStatusSuccess;

    if (isSuccess) {
      Future.microtask(() => context.go(PATH_HOME));
    }

    if (isError) {
      Future.microtask(() =>
          ErrorDialog.showError(context, title: 'Error', message: data.message ?? '죄송합니다\n잠시후 다시 시도해주세요.'));
    }

    return LoadingOverlay(isLoading: isLoading, child: SizedBox.shrink());
  }
}