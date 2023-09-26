
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/auth/providers/signin_password_provider.dart';

class SigninPasswordInput extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(signinPasswordProvider.notifier).controller;

    return TextFormField(
      controller:controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '비밀번호를 적어주세요!';
        }
        return null;
      },
      onChanged: (value) {
        ref.read(signinPasswordProvider.notifier).onChangePassword(value);
      },
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: const InputDecoration(
        hintText: '비밀번호',
        hintStyle: TextStyle(
            color: GRAY_COLOR_FONT,
            fontSize: 16,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: INPUT_BORDER_GRAY_COLOR),
        ),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.blue),
        // ),
        contentPadding:
        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}