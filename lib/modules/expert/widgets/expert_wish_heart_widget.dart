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
    var checkedData;
    var wishData;
    try{
      checkedData = ref.watch(expertCheckWishProvider(expertId));
      wishData = ref.watch(expertWishProvider);
    }catch(e){
      print(e.toString());
    }

    if (checkedData is ServerStatusDataSuccess<ResponseCheckWishModel>) {
      final bool isChecked = checkedData.data.isChecked;
      final int wishlistId = checkedData.data.id ?? 0;

      return GestureDetector(
        onTap: () {
          if (isChecked == false) {
            ref.read(expertWishProvider.notifier).onCreateWishlist(expertId, context);
          } else {
            print(wishlistId);
            if (wishlistId != 0) {
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