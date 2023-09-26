import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/auth/providers/signup_password_provider.dart';
import 'package:sip_app/modules/auth/providers/signup_password_verify_provider.dart';
import 'package:sip_app/modules/auth/providers/signup_phone_provider.dart';
import 'package:sip_app/modules/auth/widgets/signup_input_widget.dart';

class SignupPasswordInput extends ConsumerWidget {
  SignupPasswordInput();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordController = ref.watch(signupPasswordProvider.notifier).controller;
    final verifyController = ref.watch(signupPasswordVerifyProvider.notifier).controller;
    void onChangePasswordValue(String value) {
      ref.read(signupPasswordProvider.notifier).onChangePassword(value);
    }

    void onChangePasswordVerifyValue(String value) {
      ref.read(signupPasswordVerifyProvider.notifier).onChangePasswordVerify(value);
    }

    return Column(
      children: [
        SignupInput(
            isObscure: true,
            hintText: '비밀번호를 입력해주세요.',
            onChangeValue: onChangePasswordValue,
            controller: passwordController,
        ),
        SizedBox(height: 20),
        SignupInput(
            isObscure: true,
            hintText: '비밀번호를 다시 한번 입력해주세요.',
            onChangeValue: onChangePasswordVerifyValue,
            controller: verifyController,
        )
      ],
    );
  }
}