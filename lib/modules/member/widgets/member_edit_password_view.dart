
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/common/widgets/base_bottom_button.dart';
import 'package:sip_app/modules/common/widgets/base_input.dart';
import 'package:sip_app/modules/common/widgets/base_input_with_label.dart';
import 'package:sip_app/modules/member/providers/member_edit_password_provider.dart';

class MemberEditPasswordView extends ConsumerWidget {
  MemberEditPasswordView();

  Widget build(BuildContext context, WidgetRef ref) {
    void onChangePassword(String value) {
      ref.read(memberEditPasswordViewProvider.notifier).state = value;
    }

    void onChangePasswordVerify(String value) {
      ref.read(memberEditPasswordVerifyViewProvider.notifier).state = value;
    }

    void onSubmit() {
      ref.read(MemberEditPasswordNotifierProvider.notifier).onSubmit();
    }

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          BaseInputWithLabel(
              label: '비밀번호',
              hintText: '비밀번호',
              isObscure: true,
              onChangeValue: onChangePassword
          ),
          SizedBox(height: 10),
          BaseInput(
              isObscure: true,
              hintText: '비밀번호 확인',
              onChangeValue: onChangePasswordVerify
          ),

          Spacer(),
          BaseBottomButton(label: "수정하기", onClickButton: onSubmit)
        ],
      ),);

  }
}