import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/modules/auth/models/signin_email_model.dart';

final signinEmailProvider = StateNotifierProvider
<SigninEmailStateNotifier, SigninEmailModel>((ref) {
  final notifier = SigninEmailStateNotifier();

  return notifier;
});

class SigninEmailStateNotifier extends StateNotifier<SigninEmailModel> {
  final controller = TextEditingController();
  final updateEmailDebounce = Debouncer(
    Duration(seconds: 1),
    initialValue: EMPTY_STRING,
    checkEquality: false,
  );

  SigninEmailStateNotifier()
      : super(
      SigninEmailModel(
          email: EMPTY_STRING,
          isValidError: false,
          isValidSuccess: false
      )){
    updateEmailDebounce.values.listen((state) {
      validateEmail();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isValid() {
    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(state.email);

    return emailValid;
  }

  void validateEmail() {
    if (!isValid()) {
      state = state.copyWith(isValidError: true, isValidSuccess: false);
    } else {
      state = state.copyWith(isValidError: false, isValidSuccess: true);
    }
  }


  void onChangeEmail(String value) {
    state = state.copyWith(email: value);
    updateEmailDebounce.setValue(value);
  }
}