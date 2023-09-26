import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/auth/providers/signup_password_provider.dart';
import 'package:sip_app/modules/auth/providers/signup_password_verify_provider.dart';
import 'package:sip_app/modules/auth/providers/signup_phone_provider.dart';
import 'package:sip_app/modules/auth/providers/signup_submit_provider.dart';
import 'package:sip_app/modules/auth/widgets/signup_next_button_widget.dart';

class SignupSubmitButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isValidSuccessPassword = ref.watch(signupPasswordProvider).isValidSuccess ?? false;
    final bool isValidSuccessPasswordVerify = ref.watch(signupPasswordVerifyProvider).isValidSuccess ?? false;
    final canClick =  isValidSuccessPassword && isValidSuccessPasswordVerify;

    void onClickMoveNextStep() {
      ref.read(signupSubmitProvider.notifier).onSubmit();
      // context.push('/signup/password');
    }

    return GestureDetector(
        onTap:() {
          onClickMoveNextStep();
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children  : [
              Container(
                width: 160,
                height: 54,
                decoration: BoxDecoration(
                  color: canClick ? BUTTON_PRIMARY_COLOR : INPUT_BORDER_GRAY_COLOR,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('완료', style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                    ),),
                  ],
                ),
              ),
            ]
        )
    );
  }
}