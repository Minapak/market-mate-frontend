import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/expert/providers/check_expert_wish_provider.dart';
import 'package:sip_app/modules/expert/providers/expert_wish_provider.dart';
import 'package:sip_app/modules/wishlist/models/response_check_wish_model.dart';

class ExpertWishHeart extends ConsumerWidget {
  final int expertId;

  ExpertWishHeart({required this.expertId});

  Widget build(BuildContext context, WidgetRef ref) {
    final checkedData = ref.watch(expertCheckWishProvider(expertId));
    final wishData = ref.watch(expertWishProvider);

    if (checkedData is ServerStatusDataSuccess<ResponseCheckWishModel>) {
      final bool isChecked = checkedData.data.isChecked;
      final int wishlistId = checkedData.data.id ?? 0;

      return GestureDetector(
        onTap: () {
          print('isChecked:$isChecked');
          if (isChecked == false) {
            print('click1');
            ref.read(expertWishProvider.notifier).onCreateWishlist(expertId, context);
          } else {
            print(wishlistId);
            if (wishlistId != 0) {
              print('click2');
              ref.read(expertWishProvider.notifier).onDeleteWishlist(wishlistId, expertId, context);
            }
          }
        },
        child: SizedBox(
            width: 24,
            height:24,
            child: SvgPicture.asset(
              isChecked == true ? 'assets/icons/icon_heart_on_blue.svg': 'assets/icons/icon_heart_off_blue.svg',
              width: 24, height: 24,)
        ),
      );
    }
    return SizedBox.shrink();
  }
}