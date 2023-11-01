
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/auth/providers/signup_submit_provider.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/common/widgets/error_dialog_widget.dart';
import 'package:sip_app/modules/common/widgets/loading_overlay.dart';

import '../providers/experts_submit_provider.dart';

class ExpertRegisterSubmitHandler extends ConsumerWidget {
  ExpertRegisterSubmitHandler();

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final data = ref.watch(ExpertRegisterSubmitProvider as ProviderListenable);
    final String errorMessage = '이미 가입한 유저입니다.';

    final isLoading = data is ServerStatusLoading;
    final isError = data is ServerStatusError;
    final isSuccess = data is ServerStatusSuccess;

    if (isSuccess) {
      Future.microtask(() => context.go(PATH_HOME));
    }

    if (isError) {
      Future.microtask(() =>
          ErrorDialog.showError(context, title: 'Error', message: errorMessage));
    }

    return LoadingOverlay(isLoading: isLoading, child: SizedBox.shrink());
  }
}