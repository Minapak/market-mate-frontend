
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/modules/auth/providers/signup_phone_provider.dart';
import 'package:sip_app/modules/common/widgets/error_dialog_widget.dart';
import 'package:sip_app/modules/common/widgets/loading_overlay.dart';

import '../../../constants/path.dart';

class SignupPhoneHandler extends ConsumerWidget {
  SignupPhoneHandler();

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final isSuccess = ref.watch(signupPhoneProvider).isSuccess ?? false;
    final isLoading = ref.watch(signupPhoneProvider).isLoading ?? false;
    final isError = ref.watch(signupPhoneProvider).isError ?? false;
    final String errorMessage = '이미 가입한 휴대폰번호입니다.';

    if (isSuccess) {
      Future.microtask(() => context.push('/signup/password'));
    }


    if (isError) {
      Future.microtask(() =>
          ErrorDialog.showError(context, title: 'Error', message: errorMessage));
    }

    return LoadingOverlay(isLoading: isLoading, child: SizedBox.shrink());
  }
}