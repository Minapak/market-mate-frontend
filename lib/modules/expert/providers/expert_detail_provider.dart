import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';
import 'package:sip_app/modules/expert/repositories/expert_repository.dart';

class SelectExpertDetail {
  final bool isError;
  final bool isLoading;
  final ExpertModel? expert;

  SelectExpertDetail({
    required this.isError,
    required this.isLoading,
    this.expert,
  });

  SelectExpertDetail copyWith(
      {ExpertModel? expert, bool? isError, bool? isLoading}) {
    return SelectExpertDetail(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      expert: expert ?? this.expert,
    );
  }
}

final expertCacheProvider =
    StateNotifierProvider.family<ExpertStateNotifier, SelectExpertDetail, int>(
        (ref, id) {
  final Dio dio = Dio();
  final ExpertRepository repository = ExpertRepository(dio,
      baseUrl: '$SERVER_BASE_URL/users/experts/');

  final notifier = ExpertStateNotifier(repository: repository, id: id);

  return notifier;
});

class ExpertStateNotifier extends StateNotifier<SelectExpertDetail> {
  final ExpertRepository repository;
  final int id;

  ExpertStateNotifier({required this.repository, required this.id})
      : super(
            SelectExpertDetail(expert: null, isLoading: true, isError: false)) {
    getExpert(id);
  }

  void getExpert(int id) async {
    try {
      final res = await repository.getDetail(id: id);
      print(res);
      state = state.copyWith(
          isError: false, isLoading: false, expert: res.response);
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        expert: null,
      );
    }
  }
}
