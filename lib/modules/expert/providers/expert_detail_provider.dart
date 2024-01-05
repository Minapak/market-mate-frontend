import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/config/string_config.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';
import 'package:sip_app/modules/expert/repositories/expert_repository.dart';

class SelectExpertDetail {
  final bool isError;
  final bool isLoading;
  final ExpertModel? expert;
  final String expert_phone;

  SelectExpertDetail({
    required this.isError,
    required this.isLoading,
    this.expert,
    required this.expert_phone,

  });

  SelectExpertDetail copyWith(
      {ExpertModel? expert, bool? isError, bool? isLoading}) {
    return SelectExpertDetail(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      expert: expert ?? this.expert,
      expert_phone: expert_phone ?? this.expert_phone,
    );
  }
}

final expertCacheProvider =
    StateNotifierProvider.family<ExpertStateNotifier, SelectExpertDetail, int>(
        (ref, id) {
  final Dio dio = Dio();
  final ExpertRepository repository = ExpertRepository(dio,
     baseUrl: '$SERVER_BASE_URL/users/experts/');
  //baseUrl: '$SERVER_BASE_URL/users/');
  print('Baseeeeeee URL: $SERVER_BASE_URL/users/experts/');
  final notifier = ExpertStateNotifier(repository: repository, id: id, phone: '');

  return notifier;
});

class ExpertStateNotifier extends StateNotifier<SelectExpertDetail> {
  final ExpertRepository repository;
  final int id;
  final String phone;

  ExpertStateNotifier({required this.repository, required this.id, required this.phone})
      : super(
            SelectExpertDetail(expert: null, isLoading: true, isError: false, expert_phone: phone, )) {
    getExpert(id,phone);

  }

  void getExpert(int id, String phone) async {
    try {
      final res = await repository.getDetail(id: id, phone: phone);
      print(res);
      state = state.copyWith(
          isError: false, isLoading: false, expert: res.response);
    } catch (error) {
      print(error);
      state = state.copyWith(
        isLoading: false,
        isError: true,
        expert: null,
      );
    }
  }


}
