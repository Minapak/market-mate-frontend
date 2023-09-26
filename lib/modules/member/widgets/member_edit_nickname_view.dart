import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/common/widgets/base_bottom_button.dart';
import 'package:sip_app/modules/common/widgets/base_input_with_label.dart';
import 'package:sip_app/modules/member/providers/member_edit_nicnkname_provider.dart';

class MemberEditNickNameView extends ConsumerWidget {
  final String currentValue;

  MemberEditNickNameView({required this.currentValue});

  Widget build(BuildContext context, WidgetRef ref) {
    void onChangeNickname(String value) {
      ref.read(memberEditNicknameViewProvider.notifier).state = value;
    }

    void onClickSubmit (){
      final String nickname = ref.read(memberEditNicknameViewProvider);

      ref.read(memberEditNicknameProvider.notifier).onSubmit(nickname);
    }

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          BaseInputWithLabel(
              label: '이름',
              hintText: currentValue,
              onChangeValue: onChangeNickname
          ),
          Spacer(),
          BaseBottomButton(label: "수정하기", onClickButton: onClickSubmit)
        ],
    ),);
  }
}
