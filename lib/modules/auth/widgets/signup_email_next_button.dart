import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/modules/auth/providers/signup_email_provider.dart';
import 'package:sip_app/modules/auth/widgets/signup_next_button_widget.dart';

class SignupEmailNextButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isValidSuccess = ref.watch(signupEmailProvider).isValidSuccess ?? false;
    final bool isSuccess = ref.watch(signupEmailProvider).isSuccess ?? false;

    void onClickMoveNextStep() {
      if (isSuccess) {
        if (isValidSuccess){
          context.push('/signup/phone');
        }
      } else {
        ref.read(signupEmailProvider.notifier).checkEmail(context);
      }
    }

    return SignupNextButton(
        canMoveNextStep: isValidSuccess,
        onClickButton: onClickMoveNextStep
    );
  }
}