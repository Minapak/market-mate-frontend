
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/auth/providers/signin_provider.dart';
import 'package:sip_app/modules/auth/providers/signup_submit_provider.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/common/widgets/error_dialog_widget.dart';
import 'package:sip_app/modules/common/widgets/loading_overlay.dart';

class SigninHandler extends ConsumerWidget {
  SigninHandler();

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final data = ref.watch(signinProvider);
    final String errorMessage = '다시 시도 해 주세요!';

    final isLoading = data is ServerStatusLoading;
    final isError = data is ServerStatusError;
    final isSuccess = data is ServerStatusSuccess;

    if (isError) {
      Future.microtask(() =>
          ErrorDialog.showError(context, title: 'Error', message: errorMessage));
    }

    return LoadingOverlay(isLoading: isLoading, child: SizedBox.shrink());
  }
}