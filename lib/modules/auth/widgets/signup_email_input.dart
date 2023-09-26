import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/auth/providers/signup_email_provider.dart';
import 'package:sip_app/modules/auth/widgets/signup_input_widget.dart';

class SignupEmailInput extends ConsumerWidget {
  SignupEmailInput();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(signupEmailProvider.notifier).controller;
    final bool isSuccess = ref.watch(signupEmailProvider).isSuccess ?? false;
    void onChangeValue(String value) {
      ref.read(signupEmailProvider.notifier).onChangeEmail(value);
    }

    return SignupInput(
        readOnly: isSuccess,
        isObscure: false,
        onChangeValue: onChangeValue,
        controller: controller,
    );
  }
}