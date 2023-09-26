import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/modules/auth/models/signin_password_model.dart';
import 'package:sip_app/modules/auth/models/signup_password_model.dart';

final signinPasswordProvider = StateNotifierProvider<SigninPasswordStateNotifier, SigninPasswordModel>((ref) {
  final notifier = SigninPasswordStateNotifier();

  return notifier;
});

class SigninPasswordStateNotifier extends StateNotifier<SigninPasswordModel> {
  final controller = TextEditingController();
  final updatePasswordDebounce = Debouncer(
    Duration(seconds: 1),
    initialValue: EMPTY_STRING,
    checkEquality: false,
  );

  SigninPasswordStateNotifier(): super(SigninPasswordModel(password: EMPTY_STRING)){
    updatePasswordDebounce.values.listen((state) {
      validatePassword();
    });
  }

  void onChangePassword(String value) {
    state = state.copyWith(password: value);
    updatePasswordDebounce.setValue(value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isValid() {
    return state.password.length > 0 && state.password.length < 15;
  }

  void validatePassword() {
    if (!isValid()) {
      state = state.copyWith(isValidError: true, isValidSuccess: false);
    } else {
      state = state.copyWith(isValidError: false, isValidSuccess: true);
    }
  }
}