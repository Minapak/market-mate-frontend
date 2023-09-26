

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/auth/models/signup_model.dart';
import 'package:sip_app/modules/auth/providers/signup_email_provider.dart';
import 'package:sip_app/modules/auth/providers/signup_name_provider.dart';
import 'package:sip_app/modules/auth/providers/signup_password_provider.dart';
import 'package:sip_app/modules/auth/providers/signup_phone_provider.dart';
import 'package:sip_app/modules/auth/repositories/signup_repository.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';

final signupSubmitProvider = StateNotifierProvider<SignupSubmitStateNotifier,ServerStatusBase>((ref) {
  final Dio dio = Dio();
  final SignupRepository repository = SignupRepository(dio, baseUrl: '$SERVER_BASE_URL/member');
  final notifier = SignupSubmitStateNotifier(repository: repository, ref: ref);

  return notifier;
});

class SignupSubmitStateNotifier extends StateNotifier<ServerStatusBase> {
  final ref;
  final SignupRepository repository;

  SignupSubmitStateNotifier({required this.ref, required this.repository}): super(ServerStatusInitial());

  Future<void> onSubmit() async{
    print(ref.read(signupNameProvider).name);
    print(ref.read(signupEmailProvider).email);
    print(ref.read(signupPasswordProvider).password);
    print(ref.read(signupPhoneProvider).phone);
    try {
      final SignupModel data = SignupModel(
          name: ref.read(signupNameProvider).name,
          nickname: ref.read(signupNameProvider).name,
          identyKey: ref.read(signupEmailProvider).email,
          password: ref.read(signupPasswordProvider).password,
          phone: ref.read(signupPhoneProvider).phone,
          activate: true,
      );

      final res =  await repository.signup(data: data);
      print(res);
      if (res.success){
        print('success');
        state = ServerStatusSuccess();
      } else {
        print('dpfj');
        state = ServerStatusError(message: '에러');
      }

    } catch(error) {
      print(error);
      state = ServerStatusError(message: '에러');
    }
  }

}