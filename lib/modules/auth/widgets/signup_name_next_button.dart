import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/modules/auth/providers/signup_name_provider.dart';
import 'package:sip_app/modules/auth/widgets/signup_next_button_widget.dart';

class SignupNameNextButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isValidSuccess = ref.watch(signupNameProvider).isValidSuccess ?? false;

    void onClickMoveNextStep() {
      if (isValidSuccess) {
        context.push('/signup/email');
      }
    }

    return SignupNextButton(
        canMoveNextStep: isValidSuccess,
        onClickButton: onClickMoveNextStep
    );
  }
}