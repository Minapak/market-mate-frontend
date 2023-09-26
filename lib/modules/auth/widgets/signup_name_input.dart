import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/auth/providers/signup_name_provider.dart';
import 'package:sip_app/modules/auth/widgets/signup_input_widget.dart';

class SignupNameInput extends ConsumerWidget {
  SignupNameInput();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(signupNameProvider.notifier).controller;
    void onChangeValue(String value) {
      ref.read(signupNameProvider.notifier).onChangeName(value);
    }

    return SignupInput(
        isObscure: false,
        onChangeValue: onChangeValue,
        controller: controller
    );
  }
}