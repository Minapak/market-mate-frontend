import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/modules/auth/models/signup_name_model.dart';
import 'package:sip_app/modules/expert/models/expert_register_model.dart';

final ExpertUploadDetailProvider = StateNotifierProvider
<ExpertUploadDetailStateNotifier, ExpertRegisterModel>((ref) {
  final notifier = ExpertUploadDetailStateNotifier();

  return notifier;
});

class ExpertUploadDetailStateNotifier extends StateNotifier<ExpertRegisterModel> {
  final controller = TextEditingController();

  final updateDetailDebounce = Debouncer(
    Duration(seconds: 1),
    initialValue: EMPTY_STRING,
    checkEquality: false,
  );

  ExpertUploadDetailStateNotifier()
      :super(ExpertRegisterModel(
    id: ZERO,
    thumbnail: EMPTY_STRING,
    introduceExpert: EMPTY_STRING,
    introduceContent: EMPTY_STRING,
  )){
    updateDetailDebounce.values.listen((state) {
      validateid();
    });
  }

  void onChangeDetail(String value, int idValue) {
    state = state.copyWith(id: idValue);
    state = state.copyWith(thumbnail: value);
    state = state.copyWith(introduceExpert: value);
    state = state.copyWith(introduceExpert: value);
    updateDetailDebounce.setValue(value);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isValid() {
    return state.id > 0 && state.id <= 10000000;
  }

  void validateid() async {
    if (!isValid()) {
    // state = state.copyWith(isValidError: true, isValidSuccess: false);
    } else {;
   // state = state.copyWith(isValidError: false, isValidSuccess: true);
    }
  }
}