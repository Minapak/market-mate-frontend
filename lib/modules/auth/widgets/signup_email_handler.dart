
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/modules/auth/providers/signup_email_provider.dart';
import 'package:sip_app/modules/common/widgets/error_dialog_widget.dart';
import 'package:sip_app/modules/common/widgets/loading_overlay.dart';

import '../../../constants/path.dart';

class SignupEmailHandler extends ConsumerWidget {
  SignupEmailHandler();

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final isSuccess = ref.watch(signupEmailProvider).isSuccess ?? false;
    final isLoading = ref.watch(signupEmailProvider).isLoading ?? false;
    final isError = ref.watch(signupEmailProvider).isError ?? false;
    final String errorMessage = '이미 가입한 이메일입니다.';

    if (isSuccess) {
      // Future.microtask(() => context.push('/signup/phone'));
    }


    if (isError) {
      Future.microtask(() =>
          ErrorDialog.showError(context, title: 'Error', message: errorMessage));
    }

    return LoadingOverlay(isLoading: isLoading, child: SizedBox.shrink());
  }
}