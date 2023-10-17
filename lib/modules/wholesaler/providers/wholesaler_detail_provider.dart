import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/wholesaler/models/wholesaler_model.dart';
import 'package:sip_app/modules/wholesaler/repositories/wholesaler_repository.dart';

class SelectwholesalerDetail {
  final bool isError;
  final bool isLoading;
  final wholesalerModel? wholesaler;

  SelectwholesalerDetail({
    required this.isError,
    required this.isLoading,
    this.wholesaler,
  });

  SelectwholesalerDetail copyWith(
      {wholesalerModel? wholesaler, bool? isError, bool? isLoading}) {
    return SelectwholesalerDetail(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      wholesaler: wholesaler ?? this.wholesaler,
    );
  }
}

final wholesalerCacheProvider =
    StateNotifierProvider.family<wholesalerStateNotifier, SelectwholesalerDetail, int>(
        (ref, id) {
  final Dio dio = Dio();
  final wholesalerRepository repository = wholesalerRepository(dio,
      baseUrl: '$SERVER_BASE_URL/users/wholesale/');

  final notifier = wholesalerStateNotifier(repository: repository, id: id);

  return notifier;
});

class wholesalerStateNotifier extends StateNotifier<SelectwholesalerDetail> {
  final wholesalerRepository repository;
  final int id;

  wholesalerStateNotifier({required this.repository, required this.id})
      : super(
            SelectwholesalerDetail(wholesaler: null, isLoading: true, isError: false)) {
    getwholesaler(id);
  }

  void getwholesaler(int id) async {
    try {
      final res = await repository.getDetail(id: id);
      print(res);
      state = state.copyWith(
          isError: false, isLoading: false, wholesaler: res.response);
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        isError: true,
        wholesaler: null,
      );
    }
  }
}
