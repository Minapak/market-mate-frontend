
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sip_app/constants/error_message_constants.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/common/widgets/error_toast_handler.dart';
import 'package:sip_app/modules/wholesaler/providers/check_wholesaler_wish_provider.dart';
import 'package:sip_app/modules/wholesaler/repositories/wholesaler_repository.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';
import 'package:sip_app/modules/wishlist/models/create_wishlist_model.dart';

final wholesalerWishProvider = StateNotifierProvider.autoDispose<wholesalerWishStateNotifier, ServerStatusBase>((ref) {
  final Dio dio = Dio();
  final currentLocale = Intl.getCurrentLocale();
  dio.options.headers['Accept-Language'] = currentLocale;
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers["Authorization"] =
  "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzYW0xMjNAbmF2ZXIuY29tIiwiYXV0aCI6IlJPTEVfTk9STUFMX01FTUJFUiIsInVzZXJVVUlEIjoiMmM5NzgwODM4OWQyOTkzMDAxODlkM2UwMTNjZTAwMDYiLCJpZGVudHlLZXkiOiJzYW0xMjNAbmF2ZXIuY29tIiwiZXhwIjoxNjk0NDg0OTAzfQ.Gx_69JHOYPIKJNvz8geM7xb68CwGddtoLPnddJuGy8GsEOlw9zuEYAJgnn32K5wOmSalS2hbaux11EW3vNJV7w";

  final wholesalerRepository repository = wholesalerRepository(dio, baseUrl: '$SERVER_BASE_URL/users');
  final userUUID = ref.watch(memberUUIDProvider);
  final notifier = wholesalerWishStateNotifier(ref: ref,repository: repository, userUUID: userUUID);

  return notifier;
});


class wholesalerWishStateNotifier extends StateNotifier<ServerStatusBase>{
  final ref;
  final wholesalerRepository repository;
  final String userUUID;

  wholesalerWishStateNotifier({required this.ref,required this.userUUID, required this.repository})
    :super(ServerStatusInitial());

  void updateWSWish({required int wholesalerId, int? id}) {
    ref.read(wholesalerCheckWishProvider(wholesalerId).notifier)
        .updateAddWishOptimistic(id: id);
  }

  void deleteWSWish(int expertId) {
    ref.read(wholesalerCheckWishProvider(expertId).notifier)
        .updateDeleteWishOptimistic();
  }

  Future<void> onCreateWishlist(int wholesalerId, BuildContext context) async {
    try {
      // Optimistic
      updateWSWish(wholesalerId: wholesalerId);

      state = ServerStatusSuccess();

      final CreateWishlistModel data = CreateWishlistModel(userUUID: userUUID, activate: true);
      final res = await repository.createWishlist(wholesalerId: wholesalerId, data:data);
      if (res.success == false) {
        ToastHandler.showError(ERROR_ADD_EXPERT_WISHLIST, context);
        deleteWSWish(wholesalerId);
      } else {
        final id = res.response.id;
        final uuid = res.response.userUUID;
        updateWSWish(wholesalerId: wholesalerId, id: res.response.id);
      }

    } catch(error) {
      ToastHandler.showError(ERROR_ADD_EXPERT_WISHLIST, context);
      deleteWSWish(wholesalerId);
    }
  }

  Future<void> onDeleteWishlist(int wishlistId,int wholesalerId, BuildContext context) async {
    try {
      // Optimistic
      deleteWSWish(wholesalerId);
      state = ServerStatusSuccess();

      final res = await repository.deleteWishlist(userId: userUUID, wishlistId: wishlistId);
      print(res);

      if (res.success == false) {
        ToastHandler.showError(ERROR_ADD_EXPERT_WISHLIST, context);
        ref.read(wholesalerCheckWishProvider(wholesalerId).notifier).updateIsChecked(true);
      }
    } catch(error) {
      ToastHandler.showError(ERROR_ADD_EXPERT_WISHLIST, context);
      updateWSWish(wholesalerId: wholesalerId, id: wishlistId);
    }
  }
}