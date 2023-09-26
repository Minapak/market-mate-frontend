import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/modules/auth/models/signup_name_model.dart';

final signupNameProvider = StateNotifierProvider
  <SignupNameStateNotifier, SignupNameModel>((ref) {
  final notifier = SignupNameStateNotifier();

  return notifier;
});

class SignupNameStateNotifier extends StateNotifier<SignupNameModel> {
  final controller = TextEditingController();

  final updateNameDebounce = Debouncer(
    Duration(seconds: 1),
    initialValue: EMPTY_STRING,
    checkEquality: false,
  );

  SignupNameStateNotifier()
      :super(SignupNameModel(
      name: EMPTY_STRING,
      isValidError: false,
      isValidSuccess: false,
  )){
    updateNameDebounce.values.listen((state) {
      validateName();
    });
  }

  void onChangeName(String value) {
    state = state.copyWith(name: value);
    updateNameDebounce.setValue(value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isValid() {
    return state.name.length > 0 && state.name.length <= 10;
  }

  void validateName() async {
    if (!isValid()) {
      state = state.copyWith(isValidError: true, isValidSuccess: false);
    } else {;
      state = state.copyWith(isValidError: false, isValidSuccess: true);
    }
  }
}