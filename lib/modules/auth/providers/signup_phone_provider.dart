import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/modules/auth/models/signup_phone_model.dart';

final signupPhoneProvider = StateNotifierProvider
<SignupPhoneStateNotifier, SignupPhoneModel>((ref) {
  final notifier = SignupPhoneStateNotifier();

  return notifier;
});

class SignupPhoneStateNotifier extends StateNotifier<SignupPhoneModel> {
  final controller = TextEditingController();

  final updatePhoneDebounce = Debouncer(
    Duration(seconds: 1),
    initialValue: EMPTY_STRING,
    checkEquality: false,
  );

  SignupPhoneStateNotifier()
      :super(SignupPhoneModel(
    phone: EMPTY_STRING,
    isValidError: false,
    isValidSuccess: false,
  )){
    updatePhoneDebounce.values.listen((state) {
      validatePhone();
    });
  }

  void onChangePhone(String value) {
    state = state.copyWith(phone: value);
    updatePhoneDebounce.setValue(value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isValid() {
    return state.phone.length > 0 && state.phone.length <= 20;
  }

  void validatePhone() async {
    if (!isValid()) {
      state = state.copyWith(isValidError: true, isValidSuccess: false);
    } else {;
    state = state.copyWith(isValidError: false, isValidSuccess: true);
    }
  }
}