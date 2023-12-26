import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/auth/providers/signup_phone_provider.dart';
import 'package:sip_app/modules/auth/widgets/signup_input_widget.dart';

class SignupPhoneInput extends ConsumerWidget {
  SignupPhoneInput();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(signupPhoneProvider.notifier).controller;
    //final bool isSuccess = ref.watch(signupPhoneProvider).isSuccess ?? false;
    void onChangeValue(String value) {
      ref.read(signupPhoneProvider.notifier).onChangePhone(value);
    }


    return SignupInput(
        isObscure: false,
        onChangeValue: onChangeValue,
        controller: controller,
    );
  }
}