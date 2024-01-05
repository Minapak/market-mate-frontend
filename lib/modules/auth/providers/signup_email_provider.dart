import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/auth/models/signup_email_model.dart';
import 'package:sip_app/modules/auth/repositories/signup_repository.dart';

final signupEmailProvider = StateNotifierProvider
<SignupEmailStateNotifier, SignupEmailModel>((ref) {
  final Dio dio = Dio();
  final repository = SignupRepository(dio, baseUrl: '$SERVER_BASE_URL/members');
  final notifier = SignupEmailStateNotifier(repository: repository);

  return notifier;
});

class SignupEmailStateNotifier extends StateNotifier<SignupEmailModel> {
  final SignupRepository repository;
  final controller = TextEditingController();
  final updateEmailDebounce = Debouncer(
    Duration(seconds: 1),
    initialValue: EMPTY_STRING,
    checkEquality: false,
  );

  SignupEmailStateNotifier({required this.repository})
      : super(
      SignupEmailModel(
          email: EMPTY_STRING,
          isValidError: false,
          isValidSuccess: false
      )){
    updateEmailDebounce.values.listen((state) {
      validateEmail();
    });
  }

  void onChangeEmail(String value) {
    state = state.copyWith(email: value, isError: false);
    updateEmailDebounce.setValue(value);
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

  Future<void> checkEmail(BuildContext context) async {
    try {
      if (state.isValidSuccess == false || state.isValidSuccess == null) {
        return;
      }
      state = state.copyWith(isLoading: true, isError: false, isSuccess: false);
      final res = await repository.checkIdentyKey(identyKey: state.email);

      if (res.response.success) {
        state = state.copyWith(isLoading: false, isError: false, isSuccess: true);
      } else {
        state = state.copyWith(isLoading: false, isError: true, isSuccess: false);
      }

    } catch(error) {
      print(error);
      state = state.copyWith(isLoading: false, isError: true, isSuccess: false);
    }
  }
}