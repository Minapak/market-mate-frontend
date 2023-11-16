
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sip_app/constants/error_message_constants.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/common/widgets/error_toast_handler.dart';
import 'package:sip_app/modules/expert/providers/check_expert_wish_provider.dart';
import 'package:sip_app/modules/expert/repositories/expert_repository.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';
import 'package:sip_app/modules/wishlist/models/create_wishlist_model.dart';

final expertWishProvider = StateNotifierProvider.autoDispose<ExpertWishStateNotifier, ServerStatusBase>((ref) {
  final Dio dio = Dio();
  final currentLocale = Intl.getCurrentLocale();

  final ExpertRepository repository = ExpertRepository(dio, baseUrl: '$SERVER_BASE_URL/users');
  final userUUID = ref.watch(memberUUIDProvider);
  final notifier = ExpertWishStateNotifier(ref: ref,repository: repository, userUUID: userUUID);

  return notifier;
});


class ExpertWishStateNotifier extends StateNotifier<ServerStatusBase>{
  final ref;
  final ExpertRepository repository;
  final String userUUID;

  ExpertWishStateNotifier({required this.ref,required this.userUUID, required this.repository})
    :super(ServerStatusInitial());

  void updateWish({required int expertId, int? id}) {
    ref.read(expertCheckWishProvider(expertId).notifier)
        .updateAddWishOptimistic(id: id);
  }

  void deleteWish(int expertId) {
    ref.read(expertCheckWishProvider(expertId).notifier)
        .updateDeleteWishOptimistic();
  }

  Future<void> onCreateWishlist(int expertId, BuildContext context) async {
    try {
      // Optimistic
      updateWish(expertId: expertId);

      state = ServerStatusSuccess();

      final CreateWishlistModel data = CreateWishlistModel(userUUID: userUUID, activate: true);
      final res = await repository.createWishlist(expertId: expertId, data:data);
      if (res.success == false) {
        ToastHandler.showError(ERROR_ADD_EXPERT_WISHLIST, context);
        deleteWish(expertId);
      } else {
        final id = res.response.id;
        final uuid = res.response.userUUID;
        updateWish(expertId: expertId, id: res.response.id);
      }

    } catch(error) {
      ToastHandler.showError(ERROR_ADD_EXPERT_WISHLIST, context);
      deleteWish(expertId);
    }
  }

  Future<void> onDeleteWishlist(int wishlistId,int expertId, BuildContext context) async {
    try {
      // Optimistic
      deleteWish(expertId);
      state = ServerStatusSuccess();

      final res = await repository.deleteWishlist(userId: userUUID, wishlistId: wishlistId);
      print(res);

      if (res.success == false) {
        ToastHandler.showError(ERROR_ADD_EXPERT_WISHLIST, context);
        ref.read(expertCheckWishProvider(expertId).notifier).updateIsChecked(true);
      }
    } catch(error) {
      ToastHandler.showError(ERROR_ADD_EXPERT_WISHLIST, context);
      updateWish(expertId: expertId, id: wishlistId);
    }
  }
}