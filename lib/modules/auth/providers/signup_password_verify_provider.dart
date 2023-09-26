import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/modules/auth/models/signup_password_model.dart';
import 'package:sip_app/modules/auth/providers/signup_password_provider.dart';

final signupPasswordVerifyProvider = StateNotifierProvider<SignupPasswordVerifyStateNotifier, SignupPasswordVerifyModel>((ref) {
  final notifier = SignupPasswordVerifyStateNotifier(ref: ref);

  return notifier;
});

class SignupPasswordVerifyStateNotifier extends StateNotifier<SignupPasswordVerifyModel> {
  final ref;
  final controller = TextEditingController();
  final updatePasswordDebounce = Debouncer(
    Duration(seconds: 1),
    initialValue: EMPTY_STRING,
    checkEquality: false,
  );

  SignupPasswordVerifyStateNotifier({required this.ref}): super(SignupPasswordVerifyModel(passwordVerify: EMPTY_STRING)){
    updatePasswordDebounce.values.listen((state) {
      validatePassword();
    });
  }

  void onChangePasswordVerify(String value) {
    state = state.copyWith(passwordVerify: value);
    updatePasswordDebounce.setValue(value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isValid() {
    final bool isCheckLength = state.passwordVerify.length > 0 && state.passwordVerify.length < 15;
    final bool isSameToPassword =  state.passwordVerify == ref.read(signupPasswordProvider).password;

    return isCheckLength && isSameToPassword;
  }

  void validatePassword() {
    if (!isValid()) {
      state = state.copyWith(isValidError: true, isValidSuccess: false);
    } else {
      state = state.copyWith(isValidError: false, isValidSuccess: true);
    }
  }
}