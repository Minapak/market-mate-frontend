import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/modules/auth/models/signup_phone_model.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/constants/path.dart';
import '../../../constants/path.dart';
import '../repositories/signup_repository.dart';

final signupPhoneProvider = StateNotifierProvider
<SignupPhoneStateNotifier, SignupPhoneModel>((ref) {
  final Dio dio = Dio();
  final repository = SignupRepository(dio, baseUrl: '$SERVER_BASE_URL/users/sms/send');
  final notifier = SignupPhoneStateNotifier(repository: repository);

  return notifier;
});

class SignupPhoneStateNotifier extends StateNotifier<SignupPhoneModel> {
  final controller = TextEditingController();
  final SignupRepository repository;
  final updatePhoneDebounce = Debouncer(
    Duration(seconds: 1),
    initialValue: EMPTY_STRING,
    checkEquality: false,
  );

  SignupPhoneStateNotifier({required this.repository})
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
  Future<void> checkPhone(BuildContext context) async {
    try {
      if (state.isValidSuccess == false || state.isValidSuccess == null) {
        return;
      }
      state = state.copyWith(isLoading: true, isError: false, isSuccess: false);
      final res = await repository.checkIdentyKey(identyKey: state.phone);

      if (res.response.success) {
        state = state.copyWith(isLoading: false, isError: false, isSuccess: true);
        context.push('/signup/phone');
      } else {
        state = state.copyWith(isLoading: false, isError: true, isSuccess: false);
      }

    } catch(error) {
      print(error);
      state = state.copyWith(isLoading: false, isError: true, isSuccess: false);
    }
  }
}