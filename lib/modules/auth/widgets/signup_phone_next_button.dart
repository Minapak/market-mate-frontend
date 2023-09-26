import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/modules/auth/providers/signup_phone_provider.dart';
import 'package:sip_app/modules/auth/widgets/signup_next_button_widget.dart';

class SignupPhoneNextButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isValidSuccess = ref.watch(signupPhoneProvider).isValidSuccess ?? false;

    void onClickMoveNextStep() {
      if (isValidSuccess) {
        context.push('/signup/password');
      }
    }

    return SignupNextButton(
        canMoveNextStep: isValidSuccess,
        onClickButton: onClickMoveNextStep
    );
  }
}