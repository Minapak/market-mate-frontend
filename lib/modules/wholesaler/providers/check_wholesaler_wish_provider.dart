import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/wholesaler/repositories/wholesaler_repository.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';
import 'package:sip_app/modules/wishlist/models/response_check_wish_model.dart';

final wholesalerCheckWishProvider = StateNotifierProvider.family
<wholesalerCheckWishStateNotifier, ServerStatusBase, int>((ref, wholesalerId) {
  final Dio dio = Dio();
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers["Authorization"] = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzYW0xMjNAbmF2ZXIuY29tIiwiYXV0aCI6IlJPTEVfTk9STUFMX01FTUJFUiIsInVzZXJVVUlEIjoiMmM5NzgwODM4OWQyOTkzMDAxODlkM2UwMTNjZTAwMDYiLCJpZGVudHlLZXkiOiJzYW0xMjNAbmF2ZXIuY29tIiwiZXhwIjoxNjk0NjQ4MTI4fQ.lfPUSHAtEm1xvYRbtfAFjylNfytf4_Ju1PGIwEPlKcJKBE7vWygg9hBwK9_XEufJ1JeV2oq6rRFErK9N7FwGsw";

  final repository = wholesalerRepository(dio, baseUrl: '$SERVER_BASE_URL/users');
  final userUUID = ref.watch(memberUUIDProvider);
  final notifier = wholesalerCheckWishStateNotifier(repository: repository, userUUID: userUUID, wholesalerId: wholesalerId);
  return notifier;
});


class wholesalerCheckWishStateNotifier extends StateNotifier<ServerStatusBase> {
  final wholesalerRepository repository;
  final String userUUID;
  final int wholesalerId;

  wholesalerCheckWishStateNotifier({
    required this.userUUID,
    required this.repository,
    required this.wholesalerId,
  })
      : super(ServerStatusInitial()){
    checkWish();
  }

  void updateAddWishOptimistic({int? id}) {
    if (state is ServerStatusDataSuccess<ResponseCheckWishModel>) {
      final pState = state as ServerStatusDataSuccess<ResponseCheckWishModel>;
      final ResponseCheckWishModel data = pState.data.copyWith(
          isChecked: true,
          id: id ?? 0
      );

      state = ServerStatusDataSuccess(data: data);
    }
  }

  void updateDeleteWishOptimistic() {
    if (state is ServerStatusDataSuccess<ResponseCheckWishModel>) {
      final pState = state as ServerStatusDataSuccess<ResponseCheckWishModel>;
      final ResponseCheckWishModel data = pState.data.copyWith(
          isChecked: false,
          id: 0,
      );

      state = ServerStatusDataSuccess(data: data);
    }
  }

  Future<void> checkWish() async {
    try {
      final res = await repository.checkUserWish(userId: userUUID, wholesalerId: wholesalerId);
      if (res.success) {
        final data = ResponseCheckWishModel(
            isChecked: res.response.isChecked, id: res.response.id
        );
        state = ServerStatusDataSuccess(data: data);
      } else {
        state = ServerStatusError(message: '에러');
      }
    } catch(error) {
      state = ServerStatusError(message: '에러');
    }
  }
}